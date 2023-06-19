import React from 'react';
import Avatar from "@mui/material/Avatar";
import Button from "@mui/material/Button";
import CssBaseline from "@mui/material/CssBaseline";
import TextField from "@mui/material/TextField";
// import Link from "@mui/material/Link";
import Grid from "@mui/material/Grid";
import Box from "@mui/material/Box";
import LockOutlinedIcon from "@mui/icons-material/LockOutlined";
import Typography from "@mui/material/Typography";
import Container from "@mui/material/Container";
import { createTheme, ThemeProvider } from "@mui/material/styles";
import { useFormik } from "formik";
import { signInSchema } from "../utils";
import Error from "../components/Error";
import axiosInstance from "../api";
import { AxiosResponse } from "axios";
import { Link, useNavigate } from "react-router-dom";
import Header from './UI/Header';
interface Login {
  email: string;
  password: string;
}

const defaultTheme = createTheme();

export default function SignIn() {
  localStorage.removeItem('token');
  const navigate = useNavigate();
  const formik = useFormik({
    initialValues: {
      email: "",
      password: "",
    },
    validationSchema: signInSchema,
    onSubmit: (values: Login) => {
      axiosInstance
        .post("/auth/sign_in", {
          email: values.email,
          password: values.password
        })
        .then((response: AxiosResponse) => {
          localStorage.setItem('Authorization', response.headers.authorization);
          localStorage.setItem('token', response.headers['access-token']);
          localStorage.setItem('uid', response.headers.uid);
          localStorage.setItem('client', response.headers.client);
          navigate("/dashboard");
        })
        .catch((error) => {
          console.error(error);
        });
    },
  });

  const { values, handleChange, handleBlur, handleSubmit, errors, touched } =
    formik;

  return (
    <>
      <Header />
      <ThemeProvider theme={defaultTheme}>
        <Container component="main" maxWidth="xs">
          <CssBaseline />
          <Box
            sx={{
              marginTop: 8,
              display: "flex",
              flexDirection: "column",
              alignItems: "center",
            }}
          >
            <Avatar sx={{ m: 1, bgcolor: "secondary.main" }}>
              <LockOutlinedIcon />
            </Avatar>
            <Typography component="h1" variant="h5">
              Sign in
            </Typography>
            <Box
              component="form"
              onSubmit={handleSubmit}
              noValidate
              sx={{ mt: 1 }}
            >
              <TextField
                margin="normal"
                required
                fullWidth
                id="email"
                label="Email Address"
                name="email"
                autoComplete="email"
                autoFocus
                onBlur={handleBlur}
                onChange={handleChange}
                value={values.email}
              />
              <Error error={errors?.email} touched={touched?.email} />

              <TextField
                margin="normal"
                required
                fullWidth
                name="password"
                label="Password"
                type="password"
                id="password"
                autoComplete="current-password"
                onBlur={handleBlur}
                onChange={handleChange}
                value={values.password}
              />
              <Button
                color="secondary"
                type="submit"
                fullWidth
                variant="contained"
                sx={{ mt: 3, mb: 2 }}
              >
                Sign In
              </Button>
              <Grid container>
                <Grid item>
                <Link to="/signup">
                {"Don't have an account? Sign Up"}
               </Link>
                </Grid>
              </Grid>
            </Box>
          </Box>
        </Container>
      </ThemeProvider>
    </>
  );
}