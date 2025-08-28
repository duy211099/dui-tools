import { ModeToggle } from '@/components/mode-toggle';
import { Button } from '@/components/ui/button';

export default function Home() {
  return (
    <div>
      <h1>Hello World</h1>
      <Button>Say Hello</Button>
      <ModeToggle />
    </div>
  );
}
