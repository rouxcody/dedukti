module Europa.EuM (EuM, runEuM, warn, warnings
                  , configuration, parameter
                  , text
                  , Exception(..), throw, io) where

import Europa.Config
import Control.Monad.Trans
import Control.Monad.Reader
import Control.Exception
import Control.Applicative
import Text.PrettyPrint.Leijen hiding ((<$>))


instance Applicative (ReaderT Config IO) where
    pure = return
    (<*>) = ap

newtype EuM a = EuM (ReaderT Config IO a)
    deriving (Monad, MonadIO, Functor, Applicative, MonadReader Config)

runEuM :: Config -> EuM a -> IO a
runEuM conf (EuM m) = runReaderT m conf

-- | Get all global parameters.
configuration :: EuM Config
configuration = ask

-- | Select one parameter.
parameter :: (Config -> a) -> EuM a
parameter sel = sel <$> ask

-- | Register a new warning.
warn :: String -> EuM ()
warn = undefined

-- | Get the list of warnings so far.
warnings :: EuM [Doc]
warnings = undefined

-- | Shorter name for the oft used 'liftIO'.
io :: IO a -> EuM a
io = liftIO
