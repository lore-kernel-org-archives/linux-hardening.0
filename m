Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5C522635
	for <linux-hardening@vger.kernel.org>; Wed, 17 Jan 2024 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705513218; cv=none; b=g46LJTqOHTKKJNlLQXZehy++76LPsxKfg9nsaO8ihSPzv3ZyhuwhwStUhAXCR5uC5dsBgHefYTsJ9ASDbs4yiK+qKxfiHYwSAwGw04cUYsBfAuRsn88R70PFsx1yBmLRHsK51plJ48ktpj4P2QB157seRozvCq+wMKVgbnvKqCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705513218; c=relaxed/simple;
	bh=1tCHO94M8UKN08WmEP3jFP3wVBw/BzhOtvlgulB5zs4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; b=tI/dtR1gp9zRQwSbVve6BNgp0cQuVQJ/ti+eJRdyy6HIvAfZbz/q/Ru9lQEYCBMOk0AJNfgEndDgr0fVA9FOT620ewaIqy2jNknK8HDX1zLiI6mdCF5XgaQoNNJXoCfBHHSdL742atz7TvoGEH8tUp9l73Sj3C0fkkXXvF1xAqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TVFrlaQL; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TVFrlaQL"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d5f38313f9so11737875ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 17 Jan 2024 09:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705513215; x=1706118015; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HI6bavhqQV1VGnP6OfS5XotwfVqJiEyBGy8aO+1AKAU=;
        b=TVFrlaQLQTBh/S/m5XIObvDkl/AFbyuK5O6dHyWvEFzqVqJuLslAQwFVkebyc7NqjC
         PUd8cKPC7SmLUn2jXcijyt6dmiUzPZ/g9fF6+04K5VxGScjvqYHPUxNcKDo8T49xDm6M
         vdV1qe2BUoxk6Z7MFYiEC+/uhEcR9lFmUWcTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705513215; x=1706118015;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HI6bavhqQV1VGnP6OfS5XotwfVqJiEyBGy8aO+1AKAU=;
        b=V3JsS4OneR7wg6vr725mvq5QwfYcXrUxb9eNCzegkZMNlfpyqokhI2GWtjIUEEeS4f
         uO6Mf1UgpcLoH/1grlkdHneiij6zZK5sQ+iFoT4lKTKNqYliSljY1Zt2mhAjkT2daxVZ
         EC8aqaZlIOVw23wqLZLQBI0tTKEoXAZSb9IYaGae8U3ww7AmUB/DE7qoH3OVd1m1QX8g
         W2WQaW9FJ35ITfdRPlDCfiDRXATCCbs8l1P934eKA6pSxH/k5BKvK7mic3cew9XbYfjc
         quSbN5NTlHMcbP0eKAYh1CKdil2fCuX1u8LyIVVDKPd9HvShGr7nK7Uy2M9vM3c+eA3T
         zTfQ==
X-Gm-Message-State: AOJu0YzkM+GsdoeGjv8NXrniFvaXDMLPh0ZJmtoyNazWEef/BwyliS/C
	86kr82SmmwKMnaptxuefeoJ84l5BN9MNet4gFszKZhgFVw==
X-Google-Smtp-Source: AGHT+IH52fdJN93YoHDB5xj/lRsRVa+gmw/PCGVpP5CZggqbnNav6Zj6tGn0Ox6nArT7Tv1Myn7gxQ==
X-Received: by 2002:a17:902:e808:b0:1d5:e949:bc43 with SMTP id u8-20020a170902e80800b001d5e949bc43mr1730139plg.32.1705513215006;
        Wed, 17 Jan 2024 09:40:15 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t2-20020a1709028c8200b001d5d58216bdsm4615406plo.164.2024.01.17.09.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 09:40:14 -0800 (PST)
Date: Wed, 17 Jan 2024 09:40:13 -0800
From: Kees Cook <keescook@chromium.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Yang Shi <shy828301@gmail.com>, Jeffrey Vander Stoep <jeffv@google.com>,
	Jiri Slaby <jirislaby@kernel.org>, Rik van Riel <riel@surriel.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@fb.com,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Lameter <cl@linux.com>, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] mm: align larger anonymous mappings on THP boundaries
Message-ID: <202401170925.015D300A@keescook>
References: <20220809142457.4751229f@imladris.surriel.com>
 <d0a136a0-4a31-46bc-adf4-2db109a61672@kernel.org>
 <3193bf5b-4e22-412f-8c5b-68574942d9bc@kernel.org>
 <CAJuCfpHXLdQy1a2B6xN2d7quTYwg2OoZseYPZTRpU0eHHKD-sQ@mail.gmail.com>
 <CAHbLzkpEWYhRAabAhrr6zuQqh0rO-mh=NZupDxJJ1BidOt_uiA@mail.gmail.com>
 <CAJuCfpH5gwQc0mBzQ5LOMY9URCTh=58yUJd8pbzzynqAy8_yXw@mail.gmail.com>
 <CAHbLzkoOEEKakj_XCTYhAU8fJWu8in_EY-pHnw76B1=CfYMx1w@mail.gmail.com>
 <CAJuCfpH3SWTzGNQpYXbE0i2XZwodLc0SCRVYijDz2FPQJ2PpiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpH3SWTzGNQpYXbE0i2XZwodLc0SCRVYijDz2FPQJ2PpiA@mail.gmail.com>

On Tue, Jan 16, 2024 at 02:30:36PM -0800, Suren Baghdasaryan wrote:
> On Tue, Jan 16, 2024 at 2:25 PM Yang Shi <shy828301@gmail.com> wrote:
> >
> > On Tue, Jan 16, 2024 at 1:58 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > On Tue, Jan 16, 2024 at 12:56 PM Yang Shi <shy828301@gmail.com> wrote:
> > > >
> > > > On Tue, Jan 16, 2024 at 11:16 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > > > >
> > > > > On Tue, Jan 16, 2024 at 4:09 AM Jiri Slaby <jirislaby@kernel.org> wrote:
> > > > > >
> > > > > > On 16. 01. 24, 12:53, Jiri Slaby wrote:
> > > > > > > Hi,
> > > > > > >
> > > > > > > On 09. 08. 22, 20:24, Rik van Riel wrote:
> > > > > > >> Align larger anonymous memory mappings on THP boundaries by
> > > > > > >> going through thp_get_unmapped_area if THPs are enabled for
> > > > > > >> the current process.
> > > > > > >>
> > > > > > >> With this patch, larger anonymous mappings are now THP aligned.
> > > > > > >> When a malloc library allocates a 2MB or larger arena, that
> > > > > > >> arena can now be mapped with THPs right from the start, which
> > > > > > >> can result in better TLB hit rates and execution time.
> > > > > > >
> > > > > > > This appears to break 32bit processes on x86_64 (at least). In
> > > > > > > particular, 32bit kernel or firefox builds in our build system.
> > > > > > >
> > > > > > > Reverting this on top of 6.7 makes it work again.
> > > > > > >
> > > > > > > Downstream report:
> > > > > > >   https://bugzilla.suse.com/show_bug.cgi?id=1218841
> > > > > > >
> > > > > > > So running:
> > > > > > > pahole -J --btf_gen_floats -j --lang_exclude=rust
> > > > > > > --skip_encoding_btf_inconsistent_proto --btf_gen_optimized .tmp_vmlinux.btf
> > > > > > >
> > > > > > > crashes or errors out with some random errors:
> > > > > > > [182671] STRUCT idr's field 'idr_next' offset=128 bit_size=0 type=181346
> > > > > > > Error emitting field
> > > > > > >
> > > > > > > strace shows mmap() fails with ENOMEM right before the errors:
> > > > > > > 1223  mmap2(NULL, 5783552, PROT_READ|PROT_WRITE,
> > > > > > > MAP_PRIVATE|MAP_ANONYMOUS, -1, 0 <unfinished ...>
> > > > > > > ...
> > > > > > > 1223  <... mmap2 resumed>)              = -1 ENOMEM (Cannot allocate
> > > > > > > memory)
> > > > > > >
> > > > > > > Note the .tmp_vmlinux.btf above can be arbitrary, but likely large
> > > > > > > enough. For reference, one is available at:
> > > > > > > https://decibel.fi.muni.cz/~xslaby/n/btf
> > > > > > >
> > > > > > > Any ideas?
> > > > > >
> > > > > > This works around the problem, of course (but is a band-aid, not a fix):
> > > > > >
> > > > > > --- a/mm/mmap.c
> > > > > > +++ b/mm/mmap.c
> > > > > > @@ -1829,7 +1829,7 @@ get_unmapped_area(struct file *file, unsigned long
> > > > > > addr, unsigned long len,
> > > > > >                   */
> > > > > >                  pgoff = 0;
> > > > > >                  get_area = shmem_get_unmapped_area;
> > > > > > -       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> > > > > > +       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> > > > > > !in_32bit_syscall()) {
> > > > > >                  /* Ensures that larger anonymous mappings are THP
> > > > > > aligned. */
> > > > > >                  get_area = thp_get_unmapped_area;
> > > > > >          }
> > > > > >
> > > > > >
> > > > > > thp_get_unmapped_area() does not take care of the legacy stuff...
> > > > >
> > > > > This change also affects the entropy of allocations. With this patch
> > > > > Android test [1] started failing and it requires only 8 bits of
> > > > > entropy. The feedback from our security team:
> > > > >
> > > > > 8 bits of entropy is already embarrassingly low, but was necessary for
> > > > > 32 bit ARM targets with low RAM at the time. It's definitely not
> > > > > acceptable for 64 bit targets.
> > > >
> > > > Thanks for the report. Is it 32 bit only or 64 bit is also impacted?
> > > > If I understand the code correctly, it expects the address allocated
> > > > by malloc() is kind of randomized, right?
> > >
> > > Yes, correct, the test expects a certain level of address randomization.
> > > The test failure was reported while running kernel_virt_x86_64 target
> > > (Android emulator on x86), so it does impact 64bit targets.
> >
> > IIUC this breaks the "expectation" for randomized addresses returned
> > by malloc(), but it doesn't break any real Android application, right?
> > So this is a security concern instead of a real regression.
> 
> How is making a system move vulnerabile not a real regression?
> 
> >
> > I think we can make this opt-in with a knob. Anyone who outweighs
> > security could opt this feature out. However I'm wondering whether
> > Android should implement a general address randomization mechanism
> > instead of depending on "luck" if you do care about it.
> 
> This is not depending on luck. This is checking for possible
> vulnerabilities in the system.
> I admit I'm not a security expert, so I'm looping in Jeff and Kees to chime in.

Hi!

Just to chime in, but reduction in ASLR entropy is absolutely a
regression. This is userspace visible (via /proc/sys/kernel/randomize_va_space,
/proc/sys/vm/mmap_rnd*_bits) with expectations that it work as
advertised. So, while 32-bit might be already ASLR-weak, we don't want
to make things super bad nor break ASLR in compat mode under 64-bit
systems.

Having an opt-in sounds reasonable, but we need to wire it to the ASLR
sysctls in some way so nothing lying about the ASLR entropy.

-Kees

-- 
Kees Cook
