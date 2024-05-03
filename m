Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203478BF8
	for <linux-hardening@vger.kernel.org>; Fri,  3 May 2024 00:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714696887; cv=none; b=GUM9UA8RsM8UMKUSnj2oPSQH/cu5es/4DyNt098YB8PrV+qAjI4zMyRNUYCAK724sGradRiJkQB1/OwuFuRar5IBmGvqk92nj3mD6Ofk9y0oDFwR1tjd74gPqPqWeQqC8worAS3R8UI+BlIRSkstgzKV8hFlj812/1LFPR9kPyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714696887; c=relaxed/simple;
	bh=pbSDQnfcM9BD+einzGGOUVd3T1E36CfJlU1tKpjCybU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaTf9qZfHkzqwW3cuLTG70+UbhNMxbIcx0BBKBaayF0oUJ/tfMYE6y4jSADUenEjVtZRdZWZJfsHxzJ0tubmoKWWAhtvhvBd/TIItY/Dt05Hd+GD/a7fkl9Z/pdWdPI5UhwAOoz8hgdz1IPBPa/0V0XHeXv4pZMJy/0kjkwwHJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E62hMc/S; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E62hMc/S"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e65a1370b7so79983085ad.3
        for <linux-hardening@vger.kernel.org>; Thu, 02 May 2024 17:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714696885; x=1715301685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ag+GJVh/sQYDPGeOkIngGB4bIRPX939JLId/QM0OSvU=;
        b=E62hMc/SHto+4x+x0c/d1GGFMi2XNcRny4gL6X4LtWZe5jdWibBTZzsCHv45Year5g
         mGraw44ODS3o1xSHCSKlcpIYVrRUtr194f+Cx9fXOw3sCFMxLRoJ/mmcVveRbRS0KEzp
         0ps9cvxit1qKIDf7kSeohas7Hi8DlsCrb894Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714696885; x=1715301685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ag+GJVh/sQYDPGeOkIngGB4bIRPX939JLId/QM0OSvU=;
        b=Qme6wj76WR5JnCFcqASmLnONkM7Slhn1i3WBPKvcoh3eNkZKNWVHJjyeVp3C4a0iOy
         XqwB3jlFU31lGkRsl+g2nHIrD92udME4dwjIDo+4twMqFbck0jbeycUSGyKQPC0vX6zN
         2xxLhPBmvBuuoRCzd+pGbt2F9jYA79Z92oBYS/Oq009ShzZnwnMqgHmHwJILSdp7kpRE
         vSPNt1JiVdzUNGD9JRhJyRY+OfDYuMWZKh+NGJu+YEQ5EA8wRJ4ffN2g6n3LEjkqYmmC
         sosj30ARH5XG1fGJoJxyCZLpAKSIXnRAbgKc724SFauldRYt7HpPpLFx6TNJ3xM+//71
         VVNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTOp7CY1azrJ3YMnFuO+WQ2z21FmTDyDuES5Wjf4J8EWkWHYAoWYRV/uLYhJjScjfDC2E4jI0aPu4zKMTLZRmLriRBGGIsWbyxbl1pJB7q
X-Gm-Message-State: AOJu0YzpS+uzpO94qAYpJy/3CJNl9bAGc9xOzbQ/ZNKdYz2BApGKe2r9
	M4XnlVdvuZDuP26oFmdbsc6LSCY9qXL/XMaYumYErIlOWJVttk+ClmBRRiw+Bw==
X-Google-Smtp-Source: AGHT+IGVw+PoNIInYTycTHxfqWIBoyYdGBoTX5SvKBDwlvlFcv6C6IZTK45dYCllqIK8OWMFfs/z6Q==
X-Received: by 2002:a17:902:f648:b0:1e4:19e3:56cb with SMTP id m8-20020a170902f64800b001e419e356cbmr1772102plg.12.1714696885501;
        Thu, 02 May 2024 17:41:25 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f2-20020a170902ce8200b001ecf865a019sm1958663plg.224.2024.05.02.17.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 17:41:25 -0700 (PDT)
Date: Thu, 2 May 2024 17:41:23 -0700
From: Kees Cook <keescook@chromium.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Zack Rusin <zack.rusin@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Matt Atwood <matthew.s.atwood@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, linux-kbuild@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 5/5] fs: Convert struct file::f_count to refcount_long_t
Message-ID: <202405021736.574A688@keescook>
References: <20240502222252.work.690-kees@kernel.org>
 <20240502223341.1835070-5-keescook@chromium.org>
 <20240502224250.GM2118490@ZenIV>
 <202405021548.040579B1C@keescook>
 <20240502231228.GN2118490@ZenIV>
 <202405021620.C8115568@keescook>
 <20240502234152.GP2118490@ZenIV>
 <202405021708.267B02842@keescook>
 <20240503001445.GR2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503001445.GR2118490@ZenIV>

On Fri, May 03, 2024 at 01:14:45AM +0100, Al Viro wrote:
> On Thu, May 02, 2024 at 05:10:18PM -0700, Kees Cook wrote:
> 
> > But anyway, there needs to be a general "oops I hit 0"-aware form of
> > get_file(), and it seems like it should just be get_file() itself...
> 
> ... which brings back the question of what's the sane damage mitigation
> for that.  Adding arseloads of never-exercised failure exits is generally
> a bad idea - it's asking for bitrot and making the thing harder to review
> in future.

Linus seems to prefer best-effort error recovery to sprinkling BUG()s
around.  But if that's really the solution, then how about get_file()
switching to to use inc_not_zero and BUG on 0?

-- 
Kees Cook
