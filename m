Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28831925BC;
	Wed,  1 Apr 2026 07:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028003; cv=none; b=cQBEcu8uZtcP19bXMyVYOh8Y2VDRwme4y7BvgrduUGtGkt/ZGTwXHaXixI6fYiteyTvxgos24S3FeHc8gW5R2PDCrmD/bHdt8lDcxG5+c1FhduZMw4PE+ULjEXLQoBlNjC0wHR4OHAHSUMVGMf+6kshtnyQ+GC1CnZHtd61yhZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028003; c=relaxed/simple;
	bh=AaXZ1hkXmEaMbHVBuzRGZqrQ+ajhhSDVuvYdgPeGXIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aabXBWPnOAg6O/VOLe+N8tNdZoqDhTvgoqoPcHWiRbFpzlvWoBhUk5bBGtoDkOQJjxw0dvMgGoHAiZTlAzxihpBjIPuA9igR2p+/vYTAfZZgA51NZm5Q3AOnH7yyhQxpUsRhkixFynfY8B/zuhkWh6+8+bv53o0B3bMCDKvnwUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECOgKvwd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECOgKvwd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C236C2BCB3;
	Wed,  1 Apr 2026 07:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775028003;
	bh=AaXZ1hkXmEaMbHVBuzRGZqrQ+ajhhSDVuvYdgPeGXIc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ECOgKvwdJY4MCK5oFHX276N+znXANU/YjQw/Z33mc0kK0hirbKtyqJW2bIXd2EIo7
	 XI5aLMezx2oJSmsBQIj0Xh5ZFDr+29wIfuENSKclv24/7YvARNsIJO4rXiHOE2GqEU
	 zGHUj2vB99pB8BLxaKMfDhwI1u1JFmEbuSOaCniV4vop55ORupguoMKoRhJQ9IVDK0
	 B3C2LQGGqB+R7VNbmCkMznTWd1piLkjFZ4bImt39RVjb9fbfRLq9EjFDOTNX+zNN8R
	 dqkm6tlT04eukpNhXz+aT7D/WiBxdG4GUpZ7rnmFlIIRC48TxR/tkzufi8CzEd5ESV
	 yIAxUF/ulmwHw==
Message-ID: <bd0a4235-a7f0-4624-802c-aa49a9d13f29@kernel.org>
Date: Wed, 1 Apr 2026 09:19:51 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] compiler_attributes: Add overflow_behavior macros
 __ob_trap and __ob_wrap
To: Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Justin Stitt <justinstitt@google.com>, Marco Elver <elver@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, kasan-dev@googlegroups.com,
 linux-doc@vger.kernel.org, llvm@lists.linux.dev,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Nicolas Schier <nsc@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org
References: <20260331163716.work.696-kees@kernel.org>
 <20260331163725.2765789-3-kees@kernel.org>
From: Vincent Mailhol <mailhol@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20260331163725.2765789-3-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Kees,

Many thanks for this series. Great work and I am ready it with a lot of
interest!

Le 31/03/2026 à 18:37, Kees Cook a écrit :
> From: Justin Stitt <justinstitt@google.com>
> 
> When CONFIG_OVERFLOW_BEHAVIOR_TYPES=y, Clang 23+'s Overflow Behavior
> Type[1] annotations are available (i.e. __ob_trap, __ob_wrap). When not
> enabled, these need to be empty macros. Document the new annotation and
> add links from sanitizer docs pointing to the arithmetic-overflow docs.
> 
> Link: https://clang.llvm.org/docs/OverflowBehaviorTypes.html [1]
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> Co-developed-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Marco Elver <elver@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: <kasan-dev@googlegroups.com>
> Cc: <linux-doc@vger.kernel.org>
> Cc: <llvm@lists.linux.dev>
> ---
>  Documentation/dev-tools/ubsan.rst             |  13 +
>  Documentation/process/arithmetic-overflow.rst | 323 ++++++++++++++++++
>  Documentation/process/deprecated.rst          |  39 +++
>  Documentation/process/index.rst               |   1 +
>  include/linux/compiler_attributes.h           |  12 +
>  MAINTAINERS                                   |   1 +
>  6 files changed, 389 insertions(+)
>  create mode 100644 Documentation/process/arithmetic-overflow.rst
> 
> diff --git a/Documentation/dev-tools/ubsan.rst b/Documentation/dev-tools/ubsan.rst
> index e3591f8e9d5b..9e0c0f048eef 100644
> --- a/Documentation/dev-tools/ubsan.rst
> +++ b/Documentation/dev-tools/ubsan.rst
> @@ -71,6 +71,19 @@ unaligned accesses (CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y). One could
>  still enable it in config, just note that it will produce a lot of UBSAN
>  reports.
>  
> +Additional sanitizer options include::
> +
> +  CONFIG_OVERFLOW_BEHAVIOR_TYPES=y
> +
> +This enables checking for integer arithmetic wrap-around (overflow/underflow).
> +It instruments signed and unsigned integer overflow, as well as implicit
> +truncation operations. This option is currently limited to specific types
> +via the ``__ob_trap`` and ``__ob_wrap`` annotations.
> +
> +For detailed information about arithmetic overflow handling, overflow behavior
> +annotations, and best practices, see:
> +Documentation/process/arithmetic-overflow.rst
> +
>  References
>  ----------
>  
> diff --git a/Documentation/process/arithmetic-overflow.rst b/Documentation/process/arithmetic-overflow.rst
> new file mode 100644
> index 000000000000..2f19990f189b
> --- /dev/null
> +++ b/Documentation/process/arithmetic-overflow.rst
> @@ -0,0 +1,323 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _arithmetic_overflow:
> +
> +Arithmetic Overflow Resolutions for Linux
> +=========================================
> +
> +Background
> +----------
> +
> +When a calculation's result exceeds the involved storage ranges, several
> +strategies can be followed to handle such an overflow (or underflow),
> +including:
> +
> +  - Undefined (i.e. pretend it's impossible and the result depends on hardware)
> +  - Wrap around (this is what 2s-complement representation does by default)
> +  - Trap (create an exception so the problem can be handled in another way)
> +  - Saturate (explicitly hold the maximum or minimum representable value)

I just wanted to ask how much consideration was put into this last
"saturate" option.

When speaking of "safe" as in "functional safety" this seems a good
option to me. The best option is of course proper handling, but as
discussed, we are speaking of the scenario in which the code is already
buggy and which is the fallout option doing the least damage.

What I have in mind is a new __ob_saturate type qualifier. Something like:

	void foo(int num)
	{
		int __ob_saturate saturate_var = num;
	
		saturate_var += 42;
	}

would just print a warning and continue execution, thus solving the
trapping issue. The above code would generate something equivalent to that:

	void foo(int num)
	{
		int __ob_saturate saturate_var = num;
	
		if (check_add_overflow(saturate_var, increment,
				       &saturate_var) {
			WARN(true, "saturation occurred");
			saturate_var = type_max(saturate_var);
	}

People using those saturating integers could then later check that the
value is still in bound.

This is basically what your size_add() from overflow.h is already doing.
If an overflow occurred, the allocation the addition does not trap, it
just saturates and let the allocation functions properly handle the issue.

The saturation can neutralize many security attacks and can mitigate
some safety issues. Think of the Ariane 5 rocket launch: a saturation
could have prevented the unintended fireworks.

The caveat I can think of is that the old overflow check pattern becomes
invalid. Doing:

	if (saturate_var + increment < increment)

is now bogus and would need to be caught if possible by static analysis.
So those saturating integers will only be usable in newly written code
and could not be easily retrofitted.

> +In the C standard, three basic types can be involved in arithmetic, and each
> +has a default strategy for solving the overflow problem:
> +
> +  - Signed overflow is undefined
> +  - Unsigned overflow explicitly wraps around
> +  - Pointer overflow is undefined

Nitpick: the C standard uses different definitions than yours. In the
standard:

  - overflow is *always* undefined
  - unsigned integer wraparound
  - signed integer overflow

The nuance is that in the standard unsigned integers do not overflow,
they just wraparound.

I am not asking you to change your terminology, but it could be good to
state in your document that your definition of overflow differs from the
standard's definition. Maybe a terminology section could help.


Yours sincerely,
Vincent Mailhol

