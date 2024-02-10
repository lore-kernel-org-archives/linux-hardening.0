Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72399364A8
	for <linux-hardening@vger.kernel.org>; Sat, 10 Feb 2024 07:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707549213; cv=none; b=ekDGUkVAJjNmTFjop/PtG7zkRM51NZtZt1XGnW79K7HPfJff7gqbQ32Dv5KtJnQDkpOK6XkqMwTy5XAdj9o8UftriN2qvvbeOqKqWMawaadGd4QQ2VuqWFMKueNNXoi+7VaKBvzbAy0OcsMo+r48XbU+GVKGW7qNOMLpR/RcV4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707549213; c=relaxed/simple;
	bh=eLNqhG6BuOwuEDtpbLnGq2B+ck6kSMVlJ6ab7q6aBbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUGlIjC8+4gbrbxPamLkeDWKLOni6ANJ9ylu3mV2EDn2lvQw3GumKowIQvLaoWI0YiPFgnIXlTN7sgYoVch4uqLFn3LSsZ1glkyR2TY+1US/xRswAIRqHRxg7MS1CvSmSlwtrAWyrWYpUqS3rGFQ/R6a4x5n0fyIu7TQRe+1gTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZdzPUxla; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZdzPUxla"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-21920c78c9fso881941fac.1
        for <linux-hardening@vger.kernel.org>; Fri, 09 Feb 2024 23:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707549209; x=1708154009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ItG/RHS5QiD2KktNBEoaf7WVQ+4rUlZA95b1HY5B7yQ=;
        b=ZdzPUxlaFF0gJTPgCWJ7o4KR72en/vdlxxnjlbAW7KVi5uedg4dWnB/jbJ8fUGd/r8
         eblmpf+iTfZb3rdx9ABhQq4jrY5V6555iYIGgHIUYD+dqRj/726h67+nbEP7aZipvm9o
         tgYUvblUrIsr/Gc/U5XUQHF8OV4FxZsfUmOGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707549209; x=1708154009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItG/RHS5QiD2KktNBEoaf7WVQ+4rUlZA95b1HY5B7yQ=;
        b=X8Y3hQ+0BlxzwHlaJP2sEd4SoHka3JVRMh0ThfU4bGcFnFnrh5rIQmOVXQvOSTekZW
         Rcp/TGA16VS332neZHxfDmm4w9lZYnFHZvanZR2zaU1i94kZlYZPN+SAnjAFFncLvRGU
         PzZzk6mjY+76HD8J3zmJUBmKwskfVup+DvEtEs5PHvQX3ZT9aYtTeVCkR4QQTSZ87pPc
         oaUJY+k6YofJ3g5lSCZbCnDtMns/O5CxgiOGwT0K/h+M1mfo+AepYPthuYnceB6Ik8p4
         Tnd108lG2TXIGNK/4EoP0bk8T3iPx0MpFGgPjar5WXTDyfTwEWNUv6n+3WjXSQw1irMn
         S/FA==
X-Gm-Message-State: AOJu0YyxluPYwYx70KOAuHOAa9afbLroMS9IiojRgZQ84fFE5jfO+ixQ
	+Q1tmMBdaS50X61AJ5lW8EKBFI+ogBSg+Sw6BLNRo9XUqGsjWELSgYirsiN8pQ==
X-Google-Smtp-Source: AGHT+IFvXEOJCe3uJjrX4Rbsofsi7PzYGuVSH33eHEMoSLRIq1/HcJ+88W1asbpwm5g/HR9s4Wh/Kg==
X-Received: by 2002:a05:6870:e89:b0:21a:2e98:75ec with SMTP id mm9-20020a0568700e8900b0021a2e9875ecmr1764810oab.48.1707549209593;
        Fri, 09 Feb 2024 23:13:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUfN/Cc5eb2GjsAXYbFZgDAw708o5YX2rlVLoKGUMfFqNNZA4uVKyw/8T6c8ZEHIJcuFLf5e93d/0zw0MoZSsyfO3o1SWHB6PNxMOk+thlGY1FIDz6LG2vxBDpx9TA8tALOPNXFbImXOALV05n1NmHiuN3atGtz2l740zsMhdSiE0Msafll2ubX2g/5FTYTt+SsosmJJN8fkKCb4vGM+bCgKixG41T+kBVJ0ZWLh8bUbcw=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id cl3-20020a056a02098300b005dbcff5d38esm2528518pgb.68.2024.02.09.23.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 23:13:28 -0800 (PST)
Date: Fri, 9 Feb 2024 23:13:28 -0800
From: Kees Cook <keescook@chromium.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	support@areca.com.tw, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 10/10] scsi: arcmsr: Remove snprintf() from sysfs
 call-backs and replace with sysfs_emit()
Message-ID: <202402092313.DF1409889@keescook>
References: <20240208084512.3803250-1-lee@kernel.org>
 <20240208084512.3803250-11-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208084512.3803250-11-lee@kernel.org>

On Thu, Feb 08, 2024 at 08:44:22AM +0000, Lee Jones wrote:
> Since snprintf() has the documented, but still rather strange trait of
> returning the length of the data that *would have been* written to the
> array if space were available, rather than the arguably more useful
> length of data *actually* written, it is usually considered wise to use
> something else instead in order to avoid confusion.
> 
> In the case of sysfs call-backs, new wrappers exist that do just that.
> 
> Link: https://lwn.net/Articles/69419/
> Link: https://github.com/KSPP/linux/issues/105
> Signed-off-by: Lee Jones <lee@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
