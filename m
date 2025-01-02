Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D961B412C;
	Thu,  2 Jan 2025 19:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735845367; cv=none; b=i8uL9HkI2o/kGBabbxyJ3beXtbQ/GK7J72VPBDnOKkJXzI2w6XHUZrYV12c7nsTaUBN9IKb2wWJP6S7wloBk4e2xQ8xoSHDq5ojOruOsfwY5bpjVdFqpiszEovjHaYX36c4AGTeR2erFU8uAqAdSv8swypYJzzJburedQ+vIDHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735845367; c=relaxed/simple;
	bh=I2udgpY7Z/V+hiCn7t8yU5DoDRNkypw78nRChX9yNjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6CkjnUJR71pe2SzP68mU7NJpEDRB5bIhbLfMlrEppYQtaumHKMeCYQN4ooCfuCzIsasdBF7q4UKcCCVTBGV5S5c448pl9mI/Ju7oi4wzEMJuMHO2gsxA3Sv7VoX5v+uLIwY+GXL554kFym49q39NsqCiOb2doop50CEACWPqGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jE67Q3lZ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jE67Q3lZ"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54021daa6cbso12202075e87.0;
        Thu, 02 Jan 2025 11:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735845363; x=1736450163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqIxSCyYuqdK7c1rmrJ8SVgEIQ+tOD9C0wkDiXicRJE=;
        b=jE67Q3lZRFfDQMwVXeIf14IOqrZevIb1KEIsMe5Vp33PzvRWFoNDDBEnCnANhYbcba
         fE4D0d2Wqp6wDxNStTb3bF6KiJ2cJFF8/BMG243U6S3/JpRBaIuYqm+CayRG4du0/HLc
         OEHE2280ETT4CCaCYIdvmYOSwVrb7qcCpc5JVmEyZUCqU65YKtqYb+V10j7xcVvzXUR3
         86JGSlMhyqUV4Zu5i+3g3UuSKg428odJF6Jmv4jrHFaGc649gehGV05cteCptZSUuVoR
         wRu1crZoZZytAiurBDLc5ypBun5wObPiBgUtkBh8q1b51iZxsGLu1rTBgylWzo7ztEXj
         tFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735845363; x=1736450163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UqIxSCyYuqdK7c1rmrJ8SVgEIQ+tOD9C0wkDiXicRJE=;
        b=WRipQ0Zo60jFVUp58+yobSFhOds/99AY4YWnOXdAEuaxKS7DCBnOvbF7nGXK43UKWH
         sIKJLr6P4E3AomNQz3U5C5i0qBVpRzZIuu9KDIgqhvm+GlmyZh4ZbiGi2rpKPDLxeFYj
         A5igoMlQgY0asnP9RiCmxpNVn+ozSstQruJj9EDUh+Fql9DFIy5sJCTw66hIyf2o8KGv
         tHvEPpOI+lmUCJcFxu6KKUKlzmsmh1LDNjE6UNSzepCGTyFasfE78J/eqKHJm8jIzurm
         kqzGhIqtuJu3wcN/Fc/soHhZWNdYzRXQQzeiOewlyVSRIOMfy7u6q2R7hJ4bYrAkJfeG
         PjRw==
X-Forwarded-Encrypted: i=1; AJvYcCViVIIZFNOJpqi6oqCL2u/VtebRUI6JuXHhEcHw0xSErHy109lW6RwkcZvdJBN4ZQZMgXCERngHrowFQ+UU@vger.kernel.org, AJvYcCVn2mRTC/bo8PBae4k30WaqhIE2w6Hdn51dhGoEg4Q3zpmF/9X8iCXKXlblvGlcDWNGWnp6EL76N/WsuWsAnwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0NcwTww0L4GM6XbR9uo1ZKllKvPXWLLKcl9AcKARS7QDCUU+I
	vsekZOFPn/vk1nPmWjrE+d+ARxr3IXza3obh6n6imSStBrSK84VSz/7HcD6GuMjJJMoT+BF1NsZ
	mW7Zq8j3s23gUQPN98Y2UblNhg5o=
X-Gm-Gg: ASbGncvf25JPsGRJKuZJgLb+voPLkPQk3rpu00QFEOlnLGA8rmLDB1/Mam4Fnp6ONpQ
	Vdq8t/Raw0lsJEATUsz5QIoNY5ThQrnL+bj5I3vo=
X-Google-Smtp-Source: AGHT+IGkaFEDf3g3TUnmavktQOKEFtDbw+jaIpkYUf/eEXoRJds3vRbY1uTc8GDlL4Gst5X13SUuAPMaalYF6UzPuSs=
X-Received: by 2002:a05:6512:e83:b0:53e:fa8b:822e with SMTP id
 2adb3069b0e04-54229560344mr14975048e87.37.1735845362948; Thu, 02 Jan 2025
 11:16:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125202021.3684919-1-jeffxu@google.com> <20241125202021.3684919-2-jeffxu@google.com>
 <202412171248.409B10D@keescook>
In-Reply-To: <202412171248.409B10D@keescook>
From: Andrei Vagin <avagin@gmail.com>
Date: Thu, 2 Jan 2025 11:15:51 -0800
Message-ID: <CANaxB-zosDQ_0wk3TaYyP9wZ9bVK8jU4miPgz8cqNNekGg6_sQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
To: Kees Cook <kees@kernel.org>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, torvalds@linux-foundation.org, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, ojeda@kernel.org, adobriyan@gmail.com, 
	anna-maria@linutronix.de, mark.rutland@arm.com, linus.walleij@linaro.org, 
	Jason@zx2c4.com, deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, 
	hch@lst.de, peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, 
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, 
	ardb@kernel.org, Liam.Howlett@oracle.com, mhocko@suse.com, 
	42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, enh@google.com, 
	rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Dmitry Safonov <0x7f454c46@gmail.com>, Mike Rapoport <mike.rapoport@gmail.com>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 2:18=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
....
> Also from discussions it sounds like there may need to be even finer-gain
> control, likely via prctl, for dealing with the CRIU case. The proposal
> is to provide an opt-out prctl with CAP_CHECKPOINT_RESTORE? I think this
> is reasonable and lets this all work without a new CONFIG. I imagine it
> would look like:
>
> criu process (which has CAP_CHECKPOINT_RESTORE):

Hi Kees,

Sorry for the delay, I've been out of network for the last two weeks.

Overall, this approach looks good to me. However, I think the opt-out prctl
shouldn't depend on CAP_CHECKPOINT_RESTORE. There are other use cases
besides CRIU where we need to unmap or move system mappings.
For example, gVisor uses stub processes to represent guest address spaces.
gVisor unmaps all system mappings (like vdso, vvar, etc) from stub processe=
s.

>         - prctl(GET_MSEAL_SYSTEM_MAPPINGS)
>         - if set:
>                 - remember we need to mseal mappings
>                 - prctl(SET_MSEAL_SYSTEM_MAPPINGS, 0)
>                 - re-exec with --mseal-system-mappings (or something)
>         - perform the "fork a tree to restore" work
>         - in each child, move around all the mappings
>                 - if we need to mseal mappings:
>                         - prctl(SET_MSEAL_SYSTEM_MAPPINGS, 1)
>                         - mseal each system mapping
>                 - eventually drop CAP_CHECKPOINT_RESTORE
>                 - become the restored process
>

Thanks,
Andrei
