Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435C786260
	for <linux-hardening@vger.kernel.org>; Mon, 29 Apr 2024 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410650; cv=none; b=i4uxkJqL00nFsw4CHJn0N9EE6CH4uTtPmA5vgI/cvMOaDNXKaooeETS8UDpWdYGwh6GFKJqt6qJVg7FTJlom9C1Hd/TFTeH4r662DjpTRGE1SsbVRid/E756/dxjWWssauczc77+QSUaT4Dx4t+ZFeK73sk5AwGQPfu5j8POsxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410650; c=relaxed/simple;
	bh=0jNTl45Cs7ezsUWeAWbPmvCWgF+22Evr0a+0tU6atao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4uFtuO9eC/EtjeNm9hEbg3/OcOfp2CICu/Ue7rCCwVeLAwpoycq44lJ5PIIw56/LEmCtNZaZDWaPEzzKNu8rrsc1pmsZTAOsNfRZoTtxjsI6uy1VlPwo+NxVtqsl497+5LcDJyVGk3GJ1tsxJh3gE446UH6AYADQBsiByxoGmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=frNC7ypk; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="frNC7ypk"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2a55a3d0b8eso3315418a91.1
        for <linux-hardening@vger.kernel.org>; Mon, 29 Apr 2024 10:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714410647; x=1715015447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oZRgSAbzG7KcvdiTauEibDNnc/WC+ObXBWTvwKd5YyQ=;
        b=frNC7ypk1oXy4cYOUkEh1xrUZaaHRoAmacK25JOYs6LaD2a0j0PVUxBhwPNtoo+kz0
         fNI89O/2zo91YhFv3vITF6WmgBZiQLg535I5N3VbhJjbTa+ZInayKi2hMpVb9Nku4A9W
         aCk06kZU1kUVBczu5Uddf++oFugHe8ZPo8JlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714410647; x=1715015447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZRgSAbzG7KcvdiTauEibDNnc/WC+ObXBWTvwKd5YyQ=;
        b=UTG5KVXFU5ChkBnIRhruSSTBYjsrQ39ZD8YbxWXSlGLcoegME0ug4Mm2mdn5YUrfNT
         ay0f9OAfmeivZfUvjpbOAxHkT4MsJB97JKq73yDpGAiMoFpWIKC+/bCXo0opXuUPkRYh
         Zl9WqNaMK4rShj0p3bA+9W9ApRu0ywifWkzgza3OLCLL1NsV+TzdNi4iJ9TPuqsziVcv
         Hva2IuB+E9nKpEIDW7OvFsi7C2Xr26WMvO487impH7HeJnfrBS+T3TZZCXIKsCrzT1ri
         av3TVwOMNw1XUtz8DJHxwmTbN+fWOj/IDYvb8a3FTEdj6o5tsaR/LxB8hDfZu3O3jiNu
         IZSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpdD6eE4Px1WZ8Bf/0IMiT4tZ6JY3Fn9i6F4TOO6o/UoPIZ2RvB9jQe5tzl08JzBRe6wBpvg5qNi/N2MBD1poGhpzY/DXtRhXbEeAypIUf
X-Gm-Message-State: AOJu0YxZcp6swLhaWam38bOzD/FuJ9mwLsOsaeQW/b02qlhb2TmUZiZ6
	Az/IRrh2C4+WdcxXhWEH1KGB3McrUD70C3GZ5cqgE3q6JQKix7KHBlWEZc7ED8Zz1hfVGtvbv6o
	=
X-Google-Smtp-Source: AGHT+IGj3Lb7QLmCDgTM2Q+YDthSN8UMWEbIVz5Z0H2XtkJT6q8gWsIvscYSHoZhP1Lgml101nzTDA==
X-Received: by 2002:a17:90b:270d:b0:2a2:6244:32b5 with SMTP id px13-20020a17090b270d00b002a2624432b5mr368408pjb.11.1714410647531;
        Mon, 29 Apr 2024 10:10:47 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m14-20020a17090a668e00b002a6e67e197dsm19363447pjj.45.2024.04.29.10.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 10:10:46 -0700 (PDT)
Date: Mon, 29 Apr 2024 10:10:46 -0700
From: Kees Cook <keescook@chromium.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] wifi: wil6210: wmi: Use __counted_by() in
 struct wmi_set_link_monitor_cmd and avoid -Wfamnae warning
Message-ID: <202404291008.51DB333F@keescook>
References: <ZgSTCmdP+omePvWg@neat>
 <171222554691.1806092.8730005090791383928.kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171222554691.1806092.8730005090791383928.kvalo@kernel.org>

On Thu, Apr 04, 2024 at 10:12:28AM +0000, Kalle Valo wrote:
> "Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:
> 
> > Prepare for the coming implementation by GCC and Clang of the
> > __counted_by attribute. Flexible array members annotated with
> > __counted_by can have their accesses bounds-checked at run-time
> > via CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
> > (for strcpy/memcpy-family functions).
> > 
> > Also, -Wflex-array-member-not-at-end is coming in GCC-14, and we are
> > getting ready to enable it globally.
> > 
> > So, use the `DEFINE_FLEX()` helper for an on-stack definition of
> > a flexible structure where the size of the flexible-array member
> > is known at compile-time, and refactor the rest of the code,
> > accordingly.
> > 
> > So, with these changes, fix the following warning:
> > drivers/net/wireless/ath/wil6210/wmi.c:4018:49: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > 
> > Link: https://github.com/KSPP/linux/issues/202
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> > Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> 
> Patch applied to ath-next branch of ath.git, thanks.
> 
> cbb0697e0ded wifi: wil6210: wmi: Use __counted_by() in struct wmi_set_link_monitor_cmd and avoid -Wfamnae warning

Hi,

I was just walking through our patch tracker and noticed that I don't
see this patch include in -next yet (as of next-20240429). Is there a
flush of the ath-next queue planned soon? Or did I miss some change?

Thanks!

-Kees

-- 
Kees Cook
