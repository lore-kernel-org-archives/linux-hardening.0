Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DD237104E
	for <linux-hardening@vger.kernel.org>; Sat, 28 Mar 2026 21:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774734468; cv=none; b=j0oVTX9ibJNF6GBb3Nble0DDJE4pf4LY7hp3c3GeGQ9niUOY7G6fWiv4/o7EmqIJR0I6fg6RYIsr13mHKbdsPRsjEvwh9e/FXyqR0S197TkRtueZ8C8Fll0nEI/r7puiy5ZYlItY/bxe9W1Hrp2D4pLBkTnQ//LLN27Zrzb/VEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774734468; c=relaxed/simple;
	bh=yxhOb/sA1eae8EhO3b1vyRl/xrvrV9jEzITLFK3GdBo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hEZiQsAvthHstXIjvghO6s94TpDdevoVzEDHr0jms3hiU66Wp1OsGiV5JBw9wmm+kuf0Fe67p07d3NTM5gdG9eU3LQ1SvUpGAw2JaBiwEaEnR4f2kaFTvXqv4T4l1hLZ8mw8S0t8yKtjkzVYotKe4i1QMak4J9CVJ73FWSp+xbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQNKhPki; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQNKhPki"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso37558155e9.0
        for <linux-hardening@vger.kernel.org>; Sat, 28 Mar 2026 14:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774734466; x=1775339266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTm/41VbTcqn2SmQHER5I6FBnBkh8yJq74TulTex1Vs=;
        b=MQNKhPki057uq3pBfQgbmxKkXUkqk7Wtra899SReXHJn7kozsoRnOWazzHqz2TWZoA
         7/0gfPbycoEaWWvbpHBO+OqTHQgi2vmc84X38IpHsDnlLarx1bgOauRWJio5rDjoGuYx
         nuR1mQT4byzCcmbLbD8rBUdRMOYXb2PdWrpRshmBjIPDc7xkss2SmncXHxl22miAX4wD
         auPyTi/8ePg/BWly47zdemb7X+bED5oSTtk3OUBbcziyS3VvD2HgrXGVHM+vJln0OxZL
         /i8O9Efn9NKz49lU0qwFJd/wQIrawr/65YlfRapx5G2XpJlSTQM/IspdLXakU7PiWs6l
         j4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774734466; x=1775339266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JTm/41VbTcqn2SmQHER5I6FBnBkh8yJq74TulTex1Vs=;
        b=mRWP8L0xQSBmhYQxU3ue8627fJVTdKRgqVOTELRej8WFaKiRmgvO+J2esnrDtzjDWu
         j09looOOQSwVWM1POhRLOgw2lUJpHVs4J3BUo3GmEWdgAiqYPkMZE/1HN4sOopOjuA5v
         Pgm35mlAnGJbT7VNLVkLrecZlyNW5pOrFQ8vnmW2jotop30qdm7PwoSnu3divsru2VMY
         D0pRymaahcKMFpCq98PWZOwHzgmZDz+KhVBuQdC7skvkzUIRLf1NI/ugB5DSwTQbGyyT
         ivzvQG9FOv8k6v3Z4fDu5iIKzuu1qIpbE3k2Vp1xOWPIOWkK+ZmdHH1hygdOihAK+3yC
         fJLg==
X-Forwarded-Encrypted: i=1; AJvYcCVK1G4Zded8h+bCoRoWO1XdHuTRfWuDnpRj6WhD5KpR9P8PYneiKY3WyVaJ3/79eMMXnBPFUrjYTAFTHwl5mes=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2SybiX4mqjvjPA8lVcVsm+C1oqnb8gDtr1yFHI5BIYO+u+wcU
	Odey/KBGUuFmfDUjDznNkR/sg34wHipVI7CyfmLATQWcfkQnn4TM5vVGYOrmyZR6
X-Gm-Gg: ATEYQzxm39rFD8ThHpSVG2yN+9yFUVvT4h9vp8hMzDLMMQ/YE4A7bL2bcdx0PQDs5oK
	ITIP0nspEOCoDcM2aYLQ5cgQDeEQrSSA0BpRJ6flnIqTaCxJv9ErGnO0EuSGc3GoNkI6AGlhMSl
	TbmGW4NofvP6hMbvriHmr7L8z2cdIEaypYI/EzfW7r7gj9ajw3YLs2VrPZPr5ka4hz8zvXAcEoJ
	+aCh2JxvmWH+nBKEK//2vc1712uHhU/kJylnnUWcfj8WjnGyvE7H6I7JcybqUxtHGYOxHiiHmOq
	3T+rKcQipoR8s1/V1hl4tkfG4P4i/t2aoIGNsgPnOHXn6YK8CSLZ9iPSlQhk3eF2oNDyyDRwXgA
	wl1QUHLzpcz8bCTuaNx7XfC0nOFkoeIYrJ5k5flJk0jr+k/bLpiKAwD3/k3HWqLxZWjBmvnw1Ep
	35cxxDjVhahCRTeUvtfzwUGU0eDTDADRS2YYCdysXNS4S30ObXwBzA4AHF/JA/0bPE
X-Received: by 2002:a05:600c:4505:b0:483:6d42:25c6 with SMTP id 5b1f17b1804b1-48727f01296mr108891515e9.23.1774734465411;
        Sat, 28 Mar 2026 14:47:45 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c9506dsm167386745e9.7.2026.03.28.14.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 14:47:45 -0700 (PDT)
Date: Sat, 28 Mar 2026 21:47:43 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH next] string: Optimise strlen()
Message-ID: <20260328214743.6f04bda2@pumpkin>
In-Reply-To: <CAHk-=wiwRPqvYLsWn_dbFHs5hHry=5HW2OZF8pT_mBzpbJvW7Q@mail.gmail.com>
References: <20260327195737.89537-1-david.laight.linux@gmail.com>
	<CAHk-=wgADjjXEN_8ANbU_E94uxbQHW-3v5p0-pwLOtTvL+0Wrw@mail.gmail.com>
	<20260327224928.7c4220cb@pumpkin>
	<CAHk-=wgHK0tyYym=gkq4YRHMywbuETcn835=A7uSTSTPspzf1A@mail.gmail.com>
	<20260328110814.0a59e12f@pumpkin>
	<CAHk-=wiwRPqvYLsWn_dbFHs5hHry=5HW2OZF8pT_mBzpbJvW7Q@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Mar 2026 12:16:52 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, 28 Mar 2026 at 04:08, David Laight <david.laight.linux@gmail.com> wrote:
> >
> > On Fri, 27 Mar 2026 17:29:21 -0700
> > Linus Torvalds <torvalds@linux-foundation.org> wrote:  
> > > The trivial cases don't even matter, because all the cost of execve()
> > > are elsewhere for those cases.
> > >
> > > But the cases where the strings *do* matter, they are many and long.  
> >
> > Is that the strncpy_from_user() path?  
> 
> No. For annoying reasons, execve() mainly uses "strnlen_user()"
> followed by "copy_from_user()".
> 
> See fs/exec.v: copy_strings().
> 
> The reason is that it needs to know the size of the string before it
> can start copying it, because the destination address will depend on
> it.
> 
> And yes, it's racy, and yes, if y ou modify the arguments or the
> environment while an exevbe() is going on, you get what you deserve
> (but it's not a security issue, it's just a "resulting argv[] array is
> odd", but you could have made it odd in the first place, so whatever).
> 
> It would be lovely to be able to od it in one go and not walk the
> source string twice, but that's sadly not how the execve() interface
> works (or somebody would need to come up with a clever trick).

That sounds like a challenge :-)

> 
> The main user of strncpy_from_user() is the path copying: see the
> 'getname' variations in fs/namei.c.
> 
> And sometimes pathnames are short, but we had a semi-recent discussion
> about the distribution of pathname lengths due to some allocation
> optimizations recently:
> 
>     https://lore.kernel.org/all/CAGudoHEMjWCOLEp+TdKLjuguHEKn9+e+aZwfKyK_sYpTZY8HRg@mail.gmail.com/
> 
> so while short names are common, longer names aren't *uncommon*, and
> and loads that use them tend to keep using them.
> 
> We ended up aiming for ~128 bytes for the initial allocation
> (EMBEDDED_NAME_MAX is 168 in one common config) for that reason.
> 
> Don't get me wrong: there are certainly many other users of
> strnlen_user() and strncpy_from_user(), but the ones I've seen in any
> half-way normal loads are those two: execve() and pathname copying.
> 
> > I started looking at this because someone was trying to write the 'bit-masking'
> > version for (possibly) RISC-V and I deciding that they weren't making a good
> > job of it and that it probably wasn't worth while (since x86-64 just uses
> > the byte code).  
> 
> Ok.
> 
> I do think that in user space, strlen() and friends can be absolutely
> critical for some loads, because the C string model is horrible.
> 
> But in the kernel, I really don't think any of this matters. Our
> strlen() is bad not because it's bad - it's bad because nobody really
> should *care*.

You've said that before - which is why I dissuaded the RISC-V people
from writing a cache-destroying strlen().
Actually strscpy() is also optimised for long strings - that is now
being used all over the place (I think/hope most constant strings get
converted to memcpy()), I suspect the typical length is 10 bytes!
That probably wants de-optimising :-)

The 'one size fits all' for the string functions doesn't help.
If the source contained a constant 'hint' for a typical size then
an appropriate algorithm could be picked. 

> Some of our "rep scas" users have been kept around exactly because
> absolutely nobody cares, and it's a cute remnant of a very naive young
> Linus who was using them because he was trying to learn things about
> his new i80386 CPU, and started a whole small hobby project as a
> result...

When you wrote those they weren't that bad at all.
The 386 book has 'rep scas' as 5+8n (as does the 286 book) - much faster
than the equivalent instructions.
I am surprised they survived the P4.

In 1990 I was writing driver code for multi-cpu sparc systems (not solaris)
and worrying about TSO and the store buffer.
(and seeing the cpu stall for 150 clocks while the mmu did a page table walk.)

	David


> 
>                Linus

