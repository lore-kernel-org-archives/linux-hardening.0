Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E835579F
	for <linux-hardening@vger.kernel.org>; Thu, 18 Jul 2024 05:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721282225; cv=none; b=SydBE3ciW+y3ZHzS+Hfthyo+XXl2eNxehltJOOCRJq98crjwp+yPFWRE2Dl9yQB1Wf2byRR702fFy7PPnb1hqZ3gNpNlfX0cxfjHALEuOGiaxbeeEnQE3eF1hjG2ixkH5zX/JCV4Hz02KgTNKUxjctVGapS51inql7s7zdV4oj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721282225; c=relaxed/simple;
	bh=KeuIp37sSItJMXw0CV0CrfmTbBjDl/do/7WyW3FFCf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NE1N27Jpr1Cmha/hdtBCvH3GnDbVjyJW1D6K3cP9b3DE7ptjgTiB5H/SHcEFNS55r1Sp2yOm+YLFfsC1PG+JmXDbOA+BmPu3p/H9UH/4E7RCfN1JU38tfpJmDBN7CjQLkzRFE+p5t38rjoFtrtbtvqmUnyBTN+9Wjnq1v2H76Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jkreMo74; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jkreMo74"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-44e534a1fbeso133871cf.1
        for <linux-hardening@vger.kernel.org>; Wed, 17 Jul 2024 22:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721282223; x=1721887023; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pqrE9ATA+AordmR8IlRV7jP0PZ5Ao0LIRPGNfYSqazY=;
        b=jkreMo74z1iWolTeUXgLaIfmyrDvltZ45CDzDI/PTvTcSM24JOTsHMiHQGOxAITs5O
         pceSLKdnS/WImXgxvN3QWHITaYpidljmt5sI631RFr38yAogIzVLY40yiza97tsTObhg
         FXC0qTkXhkiqYyJACf0xaYXIpzeTfGkt20Azj4cmFI+FXE7ilX6Bw9zB3rjtT8V7qgBi
         Z/ykgHBd+tDyc00yz22z3GzeiRDDtzqMUcILsqkw6j/Vvo25N1P7BbWTaNyrucx+kMAu
         wrL51FyU2ad5llzt23+voIoQZKbGm5iK1dCJSxd1b/V9wKf+2gKBO+P9xZP9TbuPiKnL
         WvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721282223; x=1721887023;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pqrE9ATA+AordmR8IlRV7jP0PZ5Ao0LIRPGNfYSqazY=;
        b=EprejS8APa468Ly522FaJdOjjh4U2bU+ZpwF8aYY2EWrWskt0h6eJolPTCuMGPjY6z
         uoZ8+kaHM8dsjWdku4hxk6T3AnipmtV8wxrEM8yBaPJDcy0qt+D+B33SNWx8Dzt0a62k
         qRWoI7VIyNcwWewXU9BCn2NwA2M0ksuT39lAeM3w1GicJnxLuec7sp6MHF2QVvaEGflD
         UuXGyMm7T6y0J/qFRDEZfki7wNfGNYZp7vgM2wnUAGnQVBxgWbJZzCBMjSYmGSVZBpjv
         qJ7uJA4tQAbpb+WLiXzWFfNU5MpHJE69UpmMs4GNTKQ+lO8YQsa9KIfMPUE3SUNLMIJ3
         cXcg==
X-Forwarded-Encrypted: i=1; AJvYcCXupFJWebnVLcREDaAbdltnkEaZ52WI62X74V5OputuLLWM5HdYpjWnjP8c40Ar1+8arxVeYjvYp2OonRqRhze4bljf00V5K0TG/rXRMewh
X-Gm-Message-State: AOJu0YwtULVLfCDVUqXJyww1FPlx902iFv//4Nq/gyuQK46bqSJDvXq8
	bWAHcboX+z0ATNzAVmsZf3MAMbwHXHE8o9bxjv6IO0eQ4moBJSh3Lvum1MS45tPv747dO6/wXLY
	PqEMXjW3mgdKBckesFw+A+vXj/aJTEwqgqYQRluIHhKvrM6lhmqlF
X-Google-Smtp-Source: AGHT+IEHHebV8szgYxu+TdmREfwXaIWJ71JkN72nWUWJgLbrKQzDy3gUd6anWSr9AFwpg2m30Bn4GExHGqf3oA18zwc=
X-Received: by 2002:a05:622a:1f98:b0:43f:ff89:dfb9 with SMTP id
 d75a77b69052e-44f91ad706fmr1237151cf.6.1721282222486; Wed, 17 Jul 2024
 22:57:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717210047.work.412-kees@kernel.org>
In-Reply-To: <20240717210047.work.412-kees@kernel.org>
From: David Gow <davidgow@google.com>
Date: Thu, 18 Jul 2024 13:56:51 +0800
Message-ID: <CABVgOSnUzuS6WDdZfX+1S1G7eotxtJWyvL_QmOMRuga1kOpViw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: KUnit: Update filename best practices
To: Kees Cook <kees@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jul 2024 at 05:00, Kees Cook <kees@kernel.org> wrote:
>
> Based on feedback from Linus[1], change the suggested file naming for
> KUnit tests.
>
> Link: https://lore.kernel.org/lkml/CAHk-=wgim6pNiGTBMhP8Kd3tsB7_JTAuvNJ=XYd3wPvvk=OHog@mail.gmail.com/ [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: David Gow <davidgow@google.com>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Cc: linux-doc@vger.kernel.org
> ---

Looks good to me. Maybe we could make it clearer that the suffix is
important for the module name, so if the module is made of multiple
source files, it will need to have the _test (or, now, _kunit) suffix
added in the Makefile.

Having the extra suffix on the module name shouldn't annoy modprobe as
much, as it doesn't need the file extension. So, e.g., if we have
foo_bar.ko and tests/foo_bar_kunit.ko:
- insmod doesn't have tab completion issues, as insmod foo[TAB] will
complete the filename to foo_bar.ko.
- modprobe also is fine, as modprobe foo[TAB] will complete the module
name partially to foo_bar (and adding _k[TAB] will complete to
foo_bar_kunit).

(It could still be annoying with fancy shells which show menus, or
something, but they'll be equally annoyed by all of the other options,
as far as I can tell.)

So:
- s/_test/_kunit for the default.
- Explicitly mention the module name, in addition to the filename.
Maybe also "if the module is made of multiple source files, specify
the module name (with the _kunit suffix) in the Makefile" or similar.

Cheers,
-- David


>  Documentation/dev-tools/kunit/style.rst | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/style.rst b/Documentation/dev-tools/kunit/style.rst
> index b6d0d7359f00..761dee3f89ca 100644
> --- a/Documentation/dev-tools/kunit/style.rst
> +++ b/Documentation/dev-tools/kunit/style.rst
> @@ -188,15 +188,20 @@ For example, a Kconfig entry might look like:
>  Test File and Module Names
>  ==========================
>
> -KUnit tests can often be compiled as a module. These modules should be named
> -after the test suite, followed by ``_test``. If this is likely to conflict with
> -non-KUnit tests, the suffix ``_kunit`` can also be used.
> -
> -The easiest way of achieving this is to name the file containing the test suite
> -``<suite>_test.c`` (or, as above, ``<suite>_kunit.c``). This file should be
> -placed next to the code under test.
> +Whether a KUnit test is compiled as a separate module or via an
> +``#include`` in a core kernel source file, the files should be named
> +after the test suite, followed by ``_test``, and live in a ``tests``
> +subdirectory to avoid conflicting with regular modules or the core kernel
> +source file names (e.g. for tab-completion). If this would conflict with
> +non-KUnit tests, the suffix ``_kunit`` can be used instead.
> +
> +So for the common case, name the file containing the test suite
> +``tests/<suite>_test.c`` (or, if needed, ``tests/<suite>_kunit.c``). The
> +``tests`` directory should be placed at the same level as the
> +code under test. For example, tests for ``lib/string.c`` live in
> +``lib/tests/string_test.c``.
>
>  If the suite name contains some or all of the name of the test's parent
>  directory, it may make sense to modify the source filename to reduce redundancy.
> -For example, a ``foo_firmware`` suite could be in the ``foo/firmware_test.c``
> +For example, a ``foo_firmware`` suite could be in the ``tests/foo/firmware_test.c``
>  file.
> --
> 2.34.1
>
