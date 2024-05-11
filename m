Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1F91F61C
	for <linux-hardening@vger.kernel.org>; Sat, 11 May 2024 20:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715457894; cv=none; b=cFKFWTcMKkWp03sZEUxaz8ODgXu+FEIKK/LWbGeFw1EYLooYNaiOCd3Gd3y7f4+xiofxiCXqi9BpJCb9ZT/9WbzEPtZ/BUpf18h3nGgM0QG6NatfwVN8ezhMeRZpMzkAF8KJ1w48Rjc8ZC5tDK8XVs5/Trhz0yCZ6U9DaowYtlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715457894; c=relaxed/simple;
	bh=m0PmhIZfGfLGxB7MdP6Q++k4AXvc2nOplWPxUyw2VLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpe9hvwds0ThL8fC+R8WO+tgL7k6Ae7Tace92cFoCZDYktlVZpFQo/oRehBwBOGKDORVYLTqObUpUIGaMSeuaFRYWlcl4nyiMuoYZHq/G9YXWBpWqBauo+OYo8WUWeYUgAa0sf7NMndNiCKgudC7gkfS8Jx1nwOJ9A+TuigKUUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZDgbCTEl; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZDgbCTEl"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f44e3fd382so2688271b3a.1
        for <linux-hardening@vger.kernel.org>; Sat, 11 May 2024 13:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715457892; x=1716062692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bAxRPnoHPzaMqkCmlI5pbJkR9qG9/zkm1emY09MZiz8=;
        b=ZDgbCTEl5MhaSUfST1waVCnlPi8WVwFpmMJY3cuHXP+W0Q+fVNBcanSOgyrum5uVi0
         CLQ8ZrwK693xxvMu5UotmQ3baCfpZYhNFT5hRswwT88UYj5h12g+J/jRPjAitul0UqFE
         Uj2eGeJ9B/PnR3aMXb+xzCZIS9XLV4FyUxVGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715457892; x=1716062692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAxRPnoHPzaMqkCmlI5pbJkR9qG9/zkm1emY09MZiz8=;
        b=hTigUl1D1O0Ef5+fVJzgezGptAKhzDS7jpSCLaot/c9vXoOkOwU3m8g79R8LaficlR
         BA/M4ZX8po/mbKt+gT9EdW1dhU6xba330RvYAc1OVNVFGXqlC570z+RfXap3gHu64HHn
         nuRTklBwdJnhHfcictSc7LNqOuUa52w88Pz1C9iY8Y/4f2Osz6UCrl8ulwNR89pxHjN0
         1gdKOl3n8WpyhREZZsvRKBeDKmpb86hkiyvFcf9lr6scCvXak657oPp/JAR5gmJkmnvk
         uwj4d7nECwQFQMY91ZmdO+2oIF69ntaomRHVV6bNN9yDZ30cJ+z/mzselrb8t7jOD5Z/
         SclQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjh30rdECArN7CK7j+ZoEqG3IiQC9DMWlDB9iRqwwnxHvSsVGVarwFFkTLVBSPbqeLwVpZvHcgvPp1PgRjZVAdsli/dAhV3VlFOioNtzxu
X-Gm-Message-State: AOJu0Ywg3xTldfp9ese4tEXShwB230vNQU1GHsqWgkRlralxiksfH9gj
	3cIxqKddY1RE/GDqyaN8x0hbpxcyCq4BHCq1v3pfqroWNKz/Dpje9HBZj3m1+TRfg1IJZUQhD0o
	=
X-Google-Smtp-Source: AGHT+IEH64K5jd6mjFYb931Me09tBfbrb15HesgvKj7DyqJhBJRz3ZGnEZ6lTZAV58PL9Yzco/fyPA==
X-Received: by 2002:a05:6a20:da83:b0:1ad:8755:976 with SMTP id adf61e73a8af0-1afde0b5aa7mr6858922637.13.1715457892419;
        Sat, 11 May 2024 13:04:52 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b6d0b8c887sm3496640a91.21.2024.05.11.13.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 13:04:51 -0700 (PDT)
Date: Sat, 11 May 2024 13:04:51 -0700
From: Kees Cook <keescook@chromium.org>
To: Erick Archer <erick.archer@outlook.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] perf/x86/amd/uncore: Add flex array to struct
 amd_uncore_ctx
Message-ID: <202405111304.6A390B9D@keescook>
References: <AS8PR02MB7237E4848B44A5226BD3551C8BE02@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB7237E4848B44A5226BD3551C8BE02@AS8PR02MB7237.eurprd02.prod.outlook.com>

On Sat, May 11, 2024 at 04:51:54PM +0200, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1][2].
> 
> The "struct amd_uncore_ctx" can be refactored to use a flex array for
> the "events" member. This way, the allocation/freeing of the memory can
> be simplified.
> 
> Specifically, as the "curr" variable is a pointer to the amd_uncore_ctx
> structure and it now ends up in a flexible array:
> 
> struct amd_uncore_ctx {
>         [...]
>         struct perf_event *events[];
> };
> 
> the two-step allocation can be simplifief by using just one kzalloc_node
> function and the struct_size() helper to do the arithmetic calculation
> for the memory to be allocated.
> 
> This way, the code is more readable and safer.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/160 [2]
> Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Erick Archer <erick.archer@outlook.com>
> ---
> Hi,
> 
> This patch can be considered v4 of this other one [1]. However, since
> the patch has completely changed due to the addition of the flex array,
> I have decided to make a new series and remove the "Reviewed-by:" tag
> by Gustavo A. R. Silva and Kees cook.
> 
> [1] https://lore.kernel.org/linux-hardening/PAXPR02MB7248F46DEFA47E79677481B18B152@PAXPR02MB7248.eurprd02.prod.outlook.com/
> 
> Thanks,
> Erick
> ---
>  arch/x86/events/amd/uncore.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)

My favorite kind of patch: fewer lines, clearer code.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
