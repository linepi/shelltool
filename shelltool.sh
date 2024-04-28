export COLOR_PF='\e\['
export COLOR_SF='m'
export BLACK="${COLOR_PF}0;30${COLOR_SF}"
export RED="${COLOR_PF}0;31${COLOR_SF}"
export GREEN="${COLOR_PF}0;32${COLOR_SF}"
export YELLOW="${COLOR_PF}0;33${COLOR_SF}"
export BLUE="${COLOR_PF}0;34${COLOR_SF}"
export PURPLE="${COLOR_PF}0;35${COLOR_SF}"
export CYAN="${COLOR_PF}0;36${COLOR_SF}"
export WHITE="${COLOR_PF}0;37${COLOR_SF}"
export NC="${COLOR_PF}0${COLOR_SF}"

export BOLD_BLUE="${COLOR_PF}1;34${COLOR_SF}"
export BOLD_GREEN="${COLOR_PF}1;32${COLOR_SF}"
export BOLD_RED="${COLOR_PF}1;31${COLOR_SF}"

__SHELLTOOL_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source ${__SHELLTOOL_DIR}/preset.sh
source ${__SHELLTOOL_DIR}/common.sh
source ${__SHELLTOOL_DIR}/apps.sh
