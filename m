Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC101991BB
	for <linux-hardening@vger.kernel.org>; Mon, 18 Nov 2024 12:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731934468; cv=none; b=aNXw83WGzikIuvmpRAnw4X1bdEWB/tuv/QiiwHb0SzmBvseUi47kvpRhe3q/+7I4adfCD2rZCOEfk+AbL4Sxt/7BJ09DuvAoquQmbCbXRwtzV0pf1BExb07R3TQH1TLj/W4X0c5L2v+8bLkzd9AmO4UAzsUUTGQQn8TpuAdOqFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731934468; c=relaxed/simple;
	bh=RFZav5imPpDajhAmqlY2eOGgnED4NjQI6+JJoDQ71N0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGOHa1tYGcaXMn6Q7mD2NIfMiKICWkFOOn011r7RFh5EjqK4H+k9Hd6euV1BkxPB46ayClKiwW0WFjCGAIIV1PU4rv4mSZ/VxVneUQo4bhR68V0su5CzRfscn+VFlnR0nY6nOD9YoRp6Qr3iR85hQoyNFILtU4OIdh6nfQ6HxSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TdOZWBTK; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TdOZWBTK"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cfc18d5259so6160a12.1
        for <linux-hardening@vger.kernel.org>; Mon, 18 Nov 2024 04:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731934464; x=1732539264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFZav5imPpDajhAmqlY2eOGgnED4NjQI6+JJoDQ71N0=;
        b=TdOZWBTKFiS5gRjdYjk9+2Hyj9TFvL1/Qx0tNNCB2IgLrmjW5yvKKbk73asRnnQBli
         ilMGAV7y2yDGvQNZE4bFat/WU6KH4cC/dc0wRFGOrpcHzRy15FzIvt0K8feDzGZJXunG
         JYao2hKg+OdPml5zil28vesqetiCcX7hhKuAYxEZ+Fzik8EvCKFEDUAJdkZcs6rvXfbj
         t6zhTNj3KN/XtS2f/MLyfUKyacNLOcTiKc7K76Rjg/ZSmqpatC2ogaamGL89Knax+y7J
         QV5IMcL/ymSOWYEtHO1ALD2b7i+Hxc4oHAOFMVyRSkPQq4awbdZZrXAFRiSEvY1Q0em9
         rRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731934464; x=1732539264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFZav5imPpDajhAmqlY2eOGgnED4NjQI6+JJoDQ71N0=;
        b=w/xVvMCCPMrM+OIFZ2cEcOKAFSlUzAuYMKZzdN/6oX594qSP/X/AiwsWCHrsIn2C7M
         fP8AYFItbHPKYZUuwcM/cGx/MF7itEd4KaHKDoHo418jAniBhDYSS0jA03cL1Bh7rSlX
         VHYl4M7IWNhX25K/nxI7QrWHpV/foE/bs3exFTmfExtUqJ32KAeqMIznsWiMBqtaUjk1
         9bPI86I+kIxMjJ8b7RIVbJ4ISW7MjByC+pQ4VrdipYEKtYweDx9TMmWCTjZbJjjh46eI
         DpHrO5sIe+R6i+RtfIxTzRVW88BMrOSw86qobaQUvrf03nSuVTfyWk/hot9hZosL/dDJ
         48ug==
X-Forwarded-Encrypted: i=1; AJvYcCWOvUc+rFSCr/AiYXFfRHmXwAhG4zy0Q9NDVbfbmEXC4j8OhgI6Q+Dv9/3zQ7mYPjUckXG26PPQBWR+vmd+4/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMJE6AcB1qhigVdCF+8Coc86e/ddOm7XdHIMUSelOfQP3aOzC+
	9BsRGMwoYRXy7JxoXEqtoBt1jnfenB/8GmZlaDVlZdW4nUe95bMwsuOkjUI6O0vTASj7nfDHsg0
	xPWwWwVs6TpcUSq0sitD2EoJeq9FI6n7nGZoF
X-Gm-Gg: ASbGncv1m2tQCFvA1iDiYJHuurl9qGyUedCzqUPk660/v8ZgUkgwbgOIXrlPInCEXxG
	caBPOCMeEEdGTJ/UBghUxE53XKk2vOe3Oz9IuRtm4eh4CbTbm1tKuULdDpcw=
X-Google-Smtp-Source: AGHT+IFWl9n8jfw906nl94a7cbMwHIP9Gd4TNcFZWOOm8Tvrj69mcd0XEdLXVwoqv6yIo+K1feYbwLqCVdza/E5/6V8=
X-Received: by 2002:aa7:de84:0:b0:5cf:6f4d:c29c with SMTP id
 4fb4d7f45d1cf-5cfa298afd6mr136645a12.4.1731934463854; Mon, 18 Nov 2024
 04:54:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com> <a0372f7f-9a85-4d3e-ba20-b5911a8189e3@lucifer.local>
In-Reply-To: <a0372f7f-9a85-4d3e-ba20-b5911a8189e3@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Mon, 18 Nov 2024 13:53:46 +0100
Message-ID: <CAG48ez2vG0tr=H8csGes7HN_5HPQAh4WZU8U1G945K1GKfABPg@mail.gmail.com>
Subject: Re: [RFCv1 0/6] Page Detective
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, derek.kiernan@amd.com, 
	dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, tj@kernel.org, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, shuah@kernel.org, vegard.nossum@oracle.com, 
	vattunuru@marvell.com, schalla@marvell.com, david@redhat.com, 
	willy@infradead.org, osalvador@suse.de, usama.anjum@collabora.com, 
	andrii@kernel.org, ryan.roberts@arm.com, peterx@redhat.com, oleg@redhat.com, 
	tandersen@netflix.com, rientjes@google.com, gthelen@google.com, 
	linux-hardening@vger.kernel.org, 
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 12:17=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Sat, Nov 16, 2024 at 05:59:16PM +0000, Pasha Tatashin wrote:
> > It operates through the Linux debugfs interface, with two files: "virt"
> > and "phys".
> >
> > The "virt" file takes a virtual address and PID and outputs information
> > about the corresponding page.
> >
> > The "phys" file takes a physical address and outputs information about
> > that page.
> >
> > The output is presented via kernel log messages (can be accessed with
> > dmesg), and includes information such as the page's reference count,
> > mapping, flags, and memory cgroup. It also shows whether the page is
> > mapped in the kernel page table, and if so, how many times.
>
> I mean, even though I'm not a huge fan of kernel pointer hashing etc. thi=
s
> is obviously leaking as much information as you might want about kernel
> internal state to the point of maybe making the whole kernel pointer
> hashing thing moot.
>
> I know this requires CAP_SYS_ADMIN, but there are things that also requir=
e
> that which _still_ obscure kernel pointers.
>
> And you're outputting it all to dmesg.
>
> So yeah, a security person (Jann?) would be better placed to comment on
> this than me, but are we sure we want to do this when not in a
> CONFIG_DEBUG_VM* kernel?

I guess there are two parts to this - what root is allowed to do, and
what information we're fine with exposing to dmesg.

If the lockdown LSM is not set to LOCKDOWN_CONFIDENTIALITY_MAX, the
kernel allows root to read kernel memory through some interfaces - in
particular, BPF allows reading arbitrary kernel memory, and perf
allows reading at least some stuff (like kernel register states). With
lockdown in the most restrictive mode, the kernel tries to prevent
root from reading arbitrary kernel memory, but we don't really change
how much information goes into dmesg. (And I imagine you could
probably still get kernel pointers out of BPF somehow even in the most
restrictive lockdown mode, but that's probably not relevant.)

The main issue with dmesg is that some systems make its contents
available to code that is not running with root privileges; and I
think it is also sometimes stored persistently in unencrypted form
(like in EFI pstore) even when everything else on the system is
encrypted.
So on one hand, we definitely shouldn't print the contents of random
chunks of memory into dmesg without a good reason; on the other hand,
for example we do already print kernel register state on WARN() (which
often includes kernel pointers and could theoretically include more
sensitive data too).

So I think showing page metadata to root when requested is probably
okay as a tradeoff? And dumping that data into dmesg is maybe not
great, but acceptable as long as only root can actually trigger this?

I don't really have a strong opinion on this...


To me, a bigger issue is that dump_page() looks like it might be racy,
which is maybe not terrible in debugging code that only runs when
something has already gone wrong, but bad if it is in code that root
can trigger on demand? __dump_page() copies the given page with
memcpy(), which I don't think guarantees enough atomicity with
concurrent updates of page->mapping or such, so dump_mapping() could
probably run on a bogus pointer. Even without torn pointers, I think
there could be a UAF if the page's mapping is destroyed while we're
going through dump_page(), since the page might not be locked. And in
dump_mapping(), the strncpy_from_kernel_nofault() also doesn't guard
against concurrent renaming of the dentry, which I think again would
probably result in UAF.
So I think dump_page() in its current form is not something we should
expose to a userspace-reachable API.
