Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1656D14AAD
	for <linux-hardening@vger.kernel.org>; Sat, 17 Feb 2024 05:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708147865; cv=none; b=okEW54DLyLJoiczjp0QAyL1ww3Nd61jyEcf0krwvvSMarsjWbRhTTK2RO+YS9NlQZg35vxNye4EpzEfKPY0EFR526FPvts7RFV1UiD+cYN425MN91MmkDh/4MjMU6ERmHQBx64ruLvlzu96eXbRGfUbCXeLjcJrRaOWIQc4fJqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708147865; c=relaxed/simple;
	bh=PbafzkH81LhkpwejYVuH2b9Gw2w/z4yy4LwySp3ScDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liWRjZUHqD2G0pMXK42lhz8v7Ono2OAM/orKKAA+ra7r5BZTmk4WMhdRO3xlPlNGRxyiM67KhGy3bIIqfIlkgw5CN+RAnzS2letTJaeAIzUzYvQOw5kcuKDxDFu6enzuVFNdiNik3A69k8CBIrzufOM9DIx4AVrRXgTxaDxV2TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IpKm/CJA; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IpKm/CJA"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso2142480a12.0
        for <linux-hardening@vger.kernel.org>; Fri, 16 Feb 2024 21:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708147863; x=1708752663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pH1ffPnywlJckbhLTl8zM+cpKx6cCA6ardzfAPepLZc=;
        b=IpKm/CJAk/WIAOIXopChnAMND6ghYE7+2a3/hA0lI/pb1Tm0rvnfzzlke/J9jDn2hW
         XqMRXYhy7QLC5LKuMVYC6bLR7H37O/m+idPi9uIyFHTwHTQlTm3nfFiYU6Ix8dPuznZn
         MrldHPgkmqt8IOCKmnCZEQwVCiS6KWrqSMiEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708147863; x=1708752663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pH1ffPnywlJckbhLTl8zM+cpKx6cCA6ardzfAPepLZc=;
        b=NlURIEq9oCH0ggrc4qBip6IZLjsWZOw8CJtWz/rOtpYSDpnP2oyV69fopIqfC4eb5v
         yPuID4lKnFlyHvFAc5IYmbdSeK2ZUdAjIxFrGqulBcNtmWtx71aZWXR4JRRtcwvONtnb
         mNnJcInLpf2JX8K7SUMUHiozjKXwvItN+TEpRl3HnWBFYZtRoXRu3ysl6+emWq9KZHTB
         rT1XDKbUTgYfWnLrPU/WZ4qn9y6l7VcpFb4t0zCFBOngrgDyhVPWn1XTmgpHURlbpqAO
         SfpYkQz/ttUWCI3NWBznDKCFRYcNMynn5imMpdh96cKs6sN8y9ePLB+qWiupfKcXh5fJ
         nTFg==
X-Forwarded-Encrypted: i=1; AJvYcCWZCBA6MdtWN8Fhbkm0mWIHsZRqFCW6UiERdQv2qyPkM7U9PK2EccnPlauiAp7BmT4ECTpY2Q/dg050To+73z7sfySreu7Rw+SEn3arO2Y3
X-Gm-Message-State: AOJu0YwE99Dwx/BD8T59AAb65oM2gfi4A+uEBzth5QSfXT5hshvhX3Ui
	YtXZJP258qvePZQnQHLzQeyi3Y719MtdjGdxeFid1tQYe3iksFai5zcvJ5VxxQ==
X-Google-Smtp-Source: AGHT+IFoEmuZSigHtEIPgXAs4/5DtlTFnAAS1avxsigIbWW4ZjtTR0AyaAMva44chxBAjaTsoPprfw==
X-Received: by 2002:a05:6a20:43a2:b0:19e:ba42:4edf with SMTP id i34-20020a056a2043a200b0019eba424edfmr9398908pzl.7.1708147863364;
        Fri, 16 Feb 2024 21:31:03 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e3-20020aa798c3000000b006dfff453f8esm837201pfm.75.2024.02.16.21.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 21:31:02 -0800 (PST)
Date: Fri, 16 Feb 2024 21:31:01 -0800
From: Kees Cook <keescook@chromium.org>
To: Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Daniel Micay <danielmicay@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Brian Gerst <brgerst@gmail.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	Igor Zhbanov <i.zhbanov@omprussia.ru>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org,
	John Allen <john.allen@amd.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86/vdso: Move vDSO to mmap region
Message-ID: <202402162129.792C1AC@keescook>
References: <20240210091827.work.233-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210091827.work.233-kees@kernel.org>

On Sat, Feb 10, 2024 at 01:18:35AM -0800, Kees Cook wrote:
> The vDSO (and its initial randomization) was introduced in commit
> 2aae950b21e4 ("x86_64: Add vDSO for x86-64 with gettimeofday/clock_gettime/getcpu"),
> but had very low entropy. The entropy was improved in commit
> 394f56fe4801 ("x86_64, vdso: Fix the vdso address randomization algorithm"),
> but there is still improvement to be made.
> 
> On principle there should not be executable code at a low entropy offset
> from the stack, since the stack and executable code having separate
> randomization is part of what makes ASLR stronger.
> 
> Remove the only executable code near the stack region and give the vDSO
> the same randomized base as other mmap mappings including the linker
> and other shared objects. This results in higher entropy being provided
> and there's little to no advantage in separating this from the existing
> executable code there. This is already how other architectures like
> arm64 handle the vDSO.

Thread ping. Anyone have thoughts on this? I can carry it in -next to
see if anything melts...

-- 
Kees Cook
