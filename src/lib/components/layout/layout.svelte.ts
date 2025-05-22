const createStore = () => {
  let pageTitle = $state("Dashboard");

  return {
    get pageTitle() {
      return pageTitle;
    },

    set pageTitle(newTitle: string) {
      pageTitle = newTitle;
    },

    setPageTitle(newTitle: string) {
      pageTitle = newTitle;
    },
  };
};

export const layoutStore = createStore();
export default layoutStore;
