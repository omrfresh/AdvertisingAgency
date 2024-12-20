﻿using Microsoft.Extensions.Logging;

namespace Lab4.Infrastructure
{
    public class FileLoggerProvider(string _path) : ILoggerProvider
    {
        private readonly string path = _path;

        public ILogger CreateLogger(string categoryName)
        {
            return new FileLogger(path);
        }

        public void Dispose()
        {
        }
    }
}
