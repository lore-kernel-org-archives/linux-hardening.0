Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C462E7193
	for <linux-hardening@vger.kernel.org>; Tue, 17 Jun 2025 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750172599; cv=none; b=QWN5XDeWQhxfPxXIjPP3NgDbgKvHVcgcNb2Zk/Zv1aENaA8bEdrdWZKwInOAkKFL/RxvFg9y48ONQ2jLO6dhDYb6SPVdHvJPC+W9eIvV1ad6ClmQf0hJX6GUTV1pFLPaDuLYwKXTZDGSuxvWtDOSgscix1ADCA6AYYrXg7/HaKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750172599; c=relaxed/simple;
	bh=cBM0bl1EYdw9m/LmJstocm95QTHjddRw6azuJUPFwDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aom8Fd1kPY5iGp/RVGvoKTfrvSY6BBtM0n0B+9MGVPulfaKPMGtAvlBNDGufkh/liSpXMI8mdWodUjE4N2++IvXl9o+FNvzop9NlatdR2Uwry2VOoSX3uK4nLY/qmtzZxe/bnkEvlDsMt30KBBEiOMlrQqFZsqq8fsSi8kBFyJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EkwSVAMl; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EkwSVAMl"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-553b16a0e38so5135605e87.1
        for <linux-hardening@vger.kernel.org>; Tue, 17 Jun 2025 08:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750172593; x=1750777393; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8kro4RJTLnz5wiZbHdQt1ebP7niZRblh94LfQW2yVq0=;
        b=EkwSVAMlRBSjPuoOcaegUSjDri7TcwkfKlGbxzHLxsNqdFQYhf65Gysr5/tcshqAck
         w632tqJ34b+XmkddFD8zusqZvw48kyyA+1+DIJnOvY0+iq7G7j74P882Br7/n1hgC89M
         dhxL7Qoo0F+qdb/mbXIB8GGgIU2VfxnfyFXykn2I0UtfvTWJtk8tCfcCXxp6Wkc0dxRs
         ZZlduppDxt09Azdbtgf9bYaU2LKHtZOLDOaQ5DZYfyUCRqNZ4K1YeTZKfhU4IzoOLzUk
         9rjwiVG9/efaGh35N8pSs7uLhER4tVbKN2hzKQKUg1x5ADTHHmU1FzkvyzRXPn2owuk1
         8WyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750172593; x=1750777393;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8kro4RJTLnz5wiZbHdQt1ebP7niZRblh94LfQW2yVq0=;
        b=RVdTu1BRpjxdaRhwIXSFbDvN9UyPTJOnGNKdz12LvfMn0ZryTI72yRYCmttT7bCTPX
         PcLdedZSwTH8EgXdzHWfBPkV2mYHT+zIEfy25+v2fkszuxzhRt+d/kiPxFpbCaWYUKV6
         zrEVATw1qDOSt/aOqCA922sHBhSqbRGPkXc0IPmI8dbdiRpS3MN8SvpWYaD7ia2wCSCU
         Z2VTOWzN8Zr6VPpaoRNDuAl+nHEbOei6APJBkPkRZx4pNmXeAPvSNxXEZulxa86dG4Bz
         8018EfuFPu5uGMT0uEvPpqj86luV7zzZJgXVNFF7oJf56RQQ1tGvCQ8VCco9R3551KSf
         xG1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyK/DAXjiY4/rbfIJq7Rz9vZm3Rc6AyfA7Zbd3gaS11J3RvSrRSB8y+TeN4e3v3U+5wl9ckEMotHGrGYDaGTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTBFcOb5UAtProOo+MwcJnshqB+b3W0KdHWMSXWF9aHzepEH8R
	qpMmOlp4824C/hd+pybXKrT6YBH7FBeyFu2/I/ZWySt9GS3tz/1lY850Rc7wsUFIFa8=
X-Gm-Gg: ASbGncs0yH8fHGne3uu4jPB1PvVUBMaIKM3JSExLGGhQvxYfMPsEQkn7mdBmPzwJ/Xy
	U2EsTycYhLo+jbbVbiFydv6Pa/C8rxd8QUbv3bMXTHyA9f5RtRWIAgT5diFeRoFGxHjaM10KiNJ
	NBBhIOG27X51GfZKMBwxQ0eqr2ym9XZGbH5dFQn0+7zZbs+YqCsXX0Do6YABj+52pCvDGr+5eMU
	gqG92PR5bpPN5XVi0ugvDR1Iv5Fy1yZCv5s8zeEPfAJK5Omc/9VY4Rw2Meq+ekR6Ub8prDyCGBV
	beFVh9HfvBwcTEuxG/OI5HOpijePRKLXr17aytUx6xDq7z8SzpFyjZApU93PobWk
X-Google-Smtp-Source: AGHT+IHT9POn8wjfJ3yL9wa7ePb4/upFX9M1uvkh2r1EA9oSU/oPblXzyWWBgyX0wBY3kJqvG2nMIA==
X-Received: by 2002:a05:6512:104e:b0:553:510d:f464 with SMTP id 2adb3069b0e04-553b6ee29d9mr3569632e87.25.1750172593026;
        Tue, 17 Jun 2025 08:03:13 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deb4e27sm81250535ad.176.2025.06.17.08.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 08:03:12 -0700 (PDT)
Date: Tue, 17 Jun 2025 17:02:59 +0200
From: Petr Mladek <pmladek@suse.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	John Ogness <jogness@linutronix.de>,
	David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] printk: ringbuffer: Add KUnit test
Message-ID: <aFGDhxefzuWCwOOV@pathway.suse.cz>
References: <20250612-printk-ringbuffer-test-v3-1-550c088ee368@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250612-printk-ringbuffer-test-v3-1-550c088ee368@linutronix.de>

On Thu 2025-06-12 08:29:07, Thomas Weiﬂschuh wrote:
> The KUnit test validates the correct operation of the ringbuffer.
> A separate dedicated ringbuffer is used so that the global printk
> ringbuffer is not touched.
> 
> Co-developed-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

PS: I have got an idea to count the number of failed prb_reserve()
    calls. And it really failed from time to time.

    I played with it and came up with two more patches. I am going
    to send them tomorrow. I think that we should solve it separately
    to avoid too many respins. The current patch is very good as
    it is now.
