export COLOR_PF='\033['
export COLOR_SF='m'
export BLUE="${COLOR_PF}0;34${COLOR_SF}"
export GREEN="${COLOR_PF}0;32${COLOR_SF}"
export RED="${COLOR_PF}0;31${COLOR_SF}"
export BOLD_BLUE="${COLOR_PF}1;34${COLOR_SF}"
export BOLD_GREEN="${COLOR_PF}1;32${COLOR_SF}"
export BOLD_RED="${COLOR_PF}1;31${COLOR_SF}"
export NC="${COLOR_PF}0${COLOR_SF}"

__SHELLTOOL_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source ${__SHELLTOOL_DIR}/preset.sh
source ${__SHELLTOOL_DIR}/common.sh
source ${__SHELLTOOL_DIR}/apps.sh