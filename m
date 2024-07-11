Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496651DFE3;
	Thu, 11 Jul 2024 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720739444; cv=none; b=YdAx1o5jatbXchaY4yYHdS3KaI87jt8EEdh5FXRP12IwNyMcCTz4Qh5c8dMlDapGDlKFDcTTKLQXg2nId7zF+fx6Mox9g7i8vx1iNDoiPWtOxc95D0UUo/IBxaceTVMUnM9xyVND1nI0LKx/wGTD9c9QcIt87OIxrBhAOSGZEgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720739444; c=relaxed/simple;
	bh=ATrtSk6itwMrkk8dtkW0RYs8d3FjFdE0ZPlLBLuC9BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=di0nFHlRFgRTg4a/a6yYUrMU8ckVPZvtqritjCziKj/pYDLx8yevKeAivHHvC0CEWUJRntw+/7Grlv9rXCjfY5UCmU74uegHouxTQTqn+pbY6jlc1zpVbirWBH9uo0B/iPJgWly21JHMjmQ1WEebRE4SZ/EBW+oaKb7C5vu7zDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHZOGzRA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHZOGzRA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF884C116B1;
	Thu, 11 Jul 2024 23:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720739443;
	bh=ATrtSk6itwMrkk8dtkW0RYs8d3FjFdE0ZPlLBLuC9BQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cHZOGzRAHjvOOoOt68Qg/gvKNaljKIXl2Jwh6iH7jR7cLmtzSv9bt9PQMf+h0Qa/U
	 qbg5P8HTKkUwdusJuaKjB9ELxX7+wf2AesGCzbmv68DAVc1OvVqQ0qPkip8f1lRy8d
	 VLqzXnww7eKfqSDisKTIDUM/i3gd4CoL4QGjyUc65o8y05nFPMUvXlCiSJUb41hhvP
	 +LED4Sd+bchVuDulgLMbLuGxpEUPUQyosnWFzksPWR0leL4fZNS02hydpMT2M6gtld
	 JS3k+LJ4Imz9KiiLe15KTKgGwH4Yjht/v4vJ2cmqRAgGi37uBa6LShDp1VReUDVHfz
	 W/cRMF3D7czdA==
Date: Thu, 11 Jul 2024 16:10:43 -0700
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Mirsad Todorovac <mtodorovac69@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Peter Collingbourne <pcc@google.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86/syscall: Avoid memcpy() for ia32
 syscall_get_arguments()
Message-ID: <202407111500.B86485B3@keescook>
References: <20240708202202.work.477-kees@kernel.org>
 <20240711214450.GG27299@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711214450.GG27299@noisy.programming.kicks-ass.net>

On Thu, Jul 11, 2024 at 11:44:50PM +0200, Peter Zijlstra wrote:
> Just for my education on things foritfy; would something like:
> 
> void syscall_get_arguments(struct pt_regs *regs, unsigned long args[6])
> {
>         memcpy(args, (typeof(args))&regs->bx, 6*sizeof(args[0]));
> }

Short answer: no.

The long answer is long, and comes in two halves: the language half and
the fortify half.

First, the C standard requires that all function argument arrays be
decayed to pointers, so your prototype is semantically handled as if
it were:

void syscall_get_arguments(struct pt_regs *regs, unsigned long *args)

The "6" is just totally thrown away by the language. :(

*However* the compilers _will_ do things with it while generating
diagnostics, but only from the caller's perspective (code _inside_
has no awareness of the "6" unless the function has been inlined, sort
of). For example:

	unsigned long toosmall[4];
	...
	syscall_get_arguments(regs, toosmall);

Produces:

<source>:60:5: warning: 'syscall_get_arguments' accessing 48 bytes in a region of size 32 [-Wstringop-overflow=]
   60 |     syscall_get_arguments(regs, toosmall);
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
<source>:60:5: note: referencing argument 2 of type 'long unsigned int[6]'
<source>:49:6: note: in a call to function 'syscall_get_arguments'
   49 | void syscall_get_arguments(struct pt_regs *regs, unsigned long args[6])
      |      ^~~~~~~~~~~~~~~~~~~~~
In function 'syscall_get_arguments',
    inlined from 'passthru' at <source>:60:5:
<source>:51:10: warning: 'memcpy' forming offset [32, 47] is out of the bounds [0, 32] of object 'toosmall' with type 'long unsigned int[4]' [-Warray-bounds=]
   51 |          memcpy(args, (typeof(args))&regs->bx, 6*sizeof(args[0]));
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
<source>: In function 'passthru':
<source>:58:19: note: 'toosmall' declared here
   58 |     unsigned long toosmall[4];
      |                   ^~~~~~~~

But syscall_get_arguments() internally has no idea what size "args" is:

void noinline syscall_get_arguments(struct pt_regs *regs, unsigned long args[6])
{
	report(sizeof(args));
	report(__builtin_object_size(args, 1));
	report(__builtin_dynamic_object_size(args, 1));
        memcpy(args, (typeof(args))&regs->bx, 6*sizeof(args[0]));
}

Which reports 8, SIZE_MAX (unknown), and SIZE_MAX (unknown) respectively.

And the language is so busted about this that there is actually a
diagnostic for "don't do that" that shows up with this code:

<source>: In function 'syscall_get_arguments':
<source>:53:22: warning: 'sizeof' on array function parameter 'args' will return size of 'long unsigned int *' [-Wsizeof-array-argument]
   53 |         report(sizeof(args));
      |                      ^

_However_, if we _inline_ the function, suddenly _bos and _bdos know
what's going on since they have visibility into the actual objection
definition:

void inline syscall_get_arguments(struct pt_regs *regs, unsigned long args[6])

Now it reports 8, 32 (8 * the "toosmall" array size 4), 32 (same: _bdos
falls back to _bos if there is no dynamic component). Note this is _not_
6, but 4, the actual object size.

Using the newer arg-sized array prototypes using a named argument _does_
inform the internals, but that requires changing the calling convention
for what is supposed to be a fixed size, and only behaves at runtime,
which is just silly for compile-time fixed sizes. For example:

void noinline syscall_get_arguments(struct pt_regs *regs, int n, unsigned long args[n])
...
	syscall_get_arguments(regs, 6, toosmall);

Does report the expected things for _bdos internally (48), but not for
sizeof (8) nor _bos (SIZE_MAX). Of course if we inline it, _bos starts
working and, along with _bdos, realizes it was lied to, and reports
32 again.

The internals of fortify use _bdos, so how _bdos acts is how fortify
will determine object sizes. With _bos/_bdos, there are two cases
fortify examines: "whole object size" (type 0) and "subobject size"
(type 1), where "type" is the second argument to _bos/_bdos:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/compiler_types.h?h=v6.9#n371

The compiler's internal string API diagnostics (i.e. -Wstringop-overflow,
-Wstringop-overread) effectively perform bounds checks with type 0,
which is in line with the traditional way of treating everything as a
raw pointer and expecting to clobber everything following it. This is
terrible for mitigating security flaws, as we can't evaluate the intent
of memcpy destination bounds unambiguously if we don't know what the
destination boundaries are.

So, fortify's memcpy moved from type 0 to type 1 (over several years
now), and when doing that, we excluded doing type 1 checking on
_source_ objects because we already had so much to clean up just for
destinations. Unchecked destination object size overflows is where the
real-world linear overflow security flaws come from most often, so it
was the best use of our efforts.

But to avoid revisiting the same code twice, fortify will examine source
object sizes when it has already found a _destination_ object size
overflow (so that they can be fixed simultaneously), or when W=1 has
been enabled (so we there is always a log of it for the more sensitive
CI systems):
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/fortify-string.h?h=v6.9#n554

For the patch in this thread, the W=1 case was reported (overread of
"bx"), because normally fortify would just ignore the overread of
the source.

Finally to answer your question about working around this case, _bos/_bdos
will see right through the casting because it operates on the actual
object behind it. (And casts to an array type are illegal too.)

    unsigned long args[6];

    report(__builtin_object_size((typeof(args))&regs->bx, 1));

<source>: In function 'show':
<source>:76:34: error: cast specifies array type
   76 |     report(__builtin_object_size((typeof(args))&regs->bx, 1));
      |                                  ^

And a (char *) cast doesn't work: _bos(1) reports 8, the size of bx. Using
locals doesn't help either:

    void *ptr = (void *)&regs->bx;

    report(__builtin_object_size(ptr, 1));

Still 8. And ultimately this is good, since fortify will see through to
the actual object that could get overflowed, etc. It's the behavior we
want for the overflow defense.

For cases where we really really absolutely cannot represent things in
a way that fortify can be happy about, there is unsafe_memcpy(). Right
now, only really wild stuff uses it (some network driver protocol
layout shenanigans, bcachefs, etc). Virtually all kernel objects that
are a destination for memcpy() should be able to be represented in a
simple and unambiguous way. (And we've successfully done so, with some
fun tangents along the way, like needing to have compilers implement
-fstrict-flex-arrays=3, but that is a whole other topic.)

-Kees

-- 
Kees Cook
