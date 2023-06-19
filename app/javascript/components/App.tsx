import React from 'react';
import PageRoutes from '../routers/Index';
import { ThemeProvider } from '@emotion/react';
import { createTheme } from '@mui/material/styles';

const theme = createTheme({
  palette: {
    primary: {
      main: "#14a37f"
    },
  },
});

function App() {
  return (
    <ThemeProvider theme={theme}>
      <PageRoutes />
    </ThemeProvider>
  );
}

export default App;

