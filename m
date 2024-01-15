Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBAA17BB6
	for <linux-hardening@vger.kernel.org>; Mon, 15 Jan 2024 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
References: <69fa6015256613ed10aee996e181ebd4@horotw.com>
User-agent: mu4e 1.10.8; emacs 30.0.50
From: Sam James <sam@gentoo.org>
To: mail@horotw.com
Cc: linux-hardening@vger.kernel.org, Jakub Wilk <jwilk@jwilk.net>, Salvatore
 Bonaccorso <carnil@debian.org>, Linux Memory Management List
 <linux-mm@kvack.org>, William Kucharski <william.kucharski@oracle.com>,
 Matthew Wilcox (Oracle) <willy@infradead.org>
Subject: Re: Limited/Broken functionality of ASLR for Libs >= 2MB
Date: Mon, 15 Jan 2024 16:40:36 +0000
Organization: Gentoo
In-reply-to: <69fa6015256613ed10aee996e181ebd4@horotw.com>
Message-ID: <87il3ur1ik.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


mail@horotw.com writes:

> Hey, I read that ASLR is currently (since kernel >=5.18) broken for
> 32bit libs and reduced in effectiveness for 64bit libs... (the issue
> only arises if a lib is over 2MB).
> I confirmed this for myself but only for the 64bit case.
>
> I saw that this issue is being tracked by ubuntu
> (https://bugs.launchpad.net/ubuntu-kernel-tests/+bug/1983357).
> If this is the wrong place and I should instead report it elsewhere I
> am very sorry.

See also https://bugs.debian.org/1024149. Unfortunately, I don't
think the issue found its way upstream until now (thanks).

CCing relevant maintainers (per the Debian bug).

>
> Sources:
> https://zolutal.github.io/aslrnt/  # the page of the original
> discoverer of the bug - as far as I know
> https://infosec.exchange/@wdormann/111744168574317113
>
> How I checked that this issue is present (I used bat because it
> includes libcrypto which is a lot bigger than 2MB and not on the edge
> of 2MB like libc):
> ```python
> from subprocess import check_output
>
> def check_bit_usage(cmd):
>     res = 0x0
>     for _ in range(0, 1000):
>         out = check_output(cmd, shell=True).decode()
>         base_address = int(out.split("-")[0], 16)
>         res |= base_address
>     return hex(res)
>
> result = check_bit_usage("cat /proc/self/maps | grep ld-linux | head
> -n1")
> print(f"Result for ld-linux (smaller than 2MB): {result}")
>
> result = check_bit_usage("bat /proc/self/maps | grep libcrypto | head
> -n1")
> print(f"Result for libcrypto (bigger than 2MB): {result}")
> ```
>
> Output:
> ```
> Result for ld-linux (smaller than 2MB): 0x7ffffffff000
> Result for libcrypto (bigger than 2MB): 0x7fffffe00000
> ```
>
> This is my first time reporting an issue to the kernel so if anything
> is inappropriate please let me know.

