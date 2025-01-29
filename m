Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89821B2182
	for <linux-hardening@vger.kernel.org>; Wed, 29 Jan 2025 10:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738147174; cv=none; b=aS5ivVw+wYwVbj57oxrucm5iA0dwdwnPGslUE6raNtSn6rPLDLJdhjcXDHnt+vwZXUdsNAtuWxZeC0CMRDJXliA9guccuq19xmU5LH0NN/O+ekbxKDaO358dod4RrOefNWJwqC41qQn3j18QevZSSfs/UcklSAhBBnu594UYxbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738147174; c=relaxed/simple;
	bh=kqVwjUbjnlJELxkJIoWWR/CuVO1x3D+eOQ/D78vovQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbW68vN9hrprFEx30fgs+DwgdlJjJMyJOgIe57JAsu2bshytJS2Fy/HEu+PF5bfXCUGqH6H+wItxQpPY7q7/OAGEaZjnE6fOmN1Ae+RP79jjFoovLwOCa0ejynOXNv1WGKd8sZ7heULC3kGVh6swjcbWAiBAQUnGSoBGnSsqaZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ww6eleAk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ww6eleAk"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-437a92d7b96so67870305e9.2
        for <linux-hardening@vger.kernel.org>; Wed, 29 Jan 2025 02:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738147171; x=1738751971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DXuQkbdyyGkewg/x1sSXq76AYAME2Qa3ipTfkjF0fuk=;
        b=Ww6eleAkpIC3oTdO+oYVPZCJhdDiUXVDiw6KHLSllRas01ekrUKw/2VqCu8it7tlCC
         qCEvnzOeKOtAQ3c/uo5+DhB1OxydjXTcYDgARBT8C1c63jBBfe+ygTmoYtMb0/ZVjLzX
         dqqqSNl89SpB2f/Km8Vq1qMI6sDGzJizOW5/hrP0jM9BjkoztbLPrdoR9nlmHsnK5eSY
         9aWU1D8YJ08oCe1KaRpGHPtZTbjS+KK02K+8udIaAFGJ/emq8qs3PMwm9I5/Bbgs2HpH
         6gxzlrtBGzssien2aokCbYkc4WXz8Xdg4RLYZszaUsRqi5B+VwhjYBPb6eAIgtG/kq9D
         08Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738147171; x=1738751971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXuQkbdyyGkewg/x1sSXq76AYAME2Qa3ipTfkjF0fuk=;
        b=PT3cvxweiQf4xaCFcZ5yDtqnz+95MXy0UdiNoWzE8BRtH0NG9NPiboazvmi/cpFJ3U
         ZEYaGHLrL13wh2gyxOCPfKH6SGf7Op5mWxOKDcGVjbbEwZrA1tkECElyz0SXQqzdh8B/
         Wlt1szfSNdi9J9t9tvzSG34ee3tWBwTRC8K1x7Wb93zhXCh34rfHx/75870bzy9hBT+w
         MW7Me9LSUeGJ8sA2HdViUJRvk/xBmmXm6tBrUnXJUZtlhCRp8Y4L0hIyR2RiX0M5hj4M
         YWdCZpecf4wcQCd5wmfG8l1wzRj24nRDhtFluCjW9KlDS8waARgRXLe8RGLItilhWk5u
         2kXg==
X-Forwarded-Encrypted: i=1; AJvYcCWp8Ofo4I4Dnj9OHM900HQ2GWeSwCKTTH/fJmyPS909OZiDdD+MD+ZwXtjHBN3J4x0VxG/hAaiblFWxfT0cMLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjraa0u4ZmUySbz6ftfGo4Y0kHqJk+0vfROnLABwmIKWzzUHm6
	Ym+O+UKxlAiezXyCe4JLxvFNaltpMXDsqWe1r5hcaN82ygVJ9GELrK7e3uyJ2V4=
X-Gm-Gg: ASbGnct+RPLfbBIUIUC/HGdFKnk1fRNfuA1IM/VkJni5gMNcyBKFdDKRZrxs5fJWZ7n
	HgLB/sgJ7gO77PgaEVae+qwVFH1/r6a/XCVEluWp1zOlxFCS68UB7R6fPdjEIKP6rjYuNppX/dQ
	skOlfFVOT5ngkjbiiFZxuweATeohmzkWy89gYAFhM3SEGx420f7g3E86TjH5NUgpuW5UIWleEnZ
	5IzXdLMBjjSy5Z2XkOZFAPuN93pzfL73dlOUQWMBDn/N9nrduiJ9VmqQWnpFjTSEBZarWcSYdzU
	Yc4LboU9BhLBvqa20nGw
X-Google-Smtp-Source: AGHT+IHZ7PAvL5v3CmKiPbyr9nq3Wq/toybDruwI5RJxeKrfmVsxqE3KQhn1Qezelc1jVzK7rqRZOw==
X-Received: by 2002:a05:600c:1c93:b0:435:9ed3:5698 with SMTP id 5b1f17b1804b1-438dc41d1cbmr19499005e9.24.1738147171073;
        Wed, 29 Jan 2025 02:39:31 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc6df1esm17980085e9.27.2025.01.29.02.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 02:39:30 -0800 (PST)
Date: Wed, 29 Jan 2025 13:39:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] container_of: add container_first() macro
Message-ID: <06aa1194-a7aa-4a5a-adb8-f6cd447d35d9@stanley.mountain>
References: <Z5m76U5zh34WbeQY@kspp>
 <2025012955-hypnotic-patronize-8931@gregkh>
 <f6e24dfa-450e-4de6-87a6-6fcf7d83888d@embeddedor.com>
 <2025012921-dense-unplanted-952b@gregkh>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025012921-dense-unplanted-952b@gregkh>

On Wed, Jan 29, 2025 at 09:34:07AM +0100, Greg KH wrote:
> On Wed, Jan 29, 2025 at 06:35:18PM +1030, Gustavo A. R. Silva wrote:
> > 
> > 
> > On 29/01/25 16:24, Greg KH wrote:
> > > On Wed, Jan 29, 2025 at 03:56:01PM +1030, Gustavo A. R. Silva wrote:
> > > > This is like container_of_const() but it contains an assert to
> > > > ensure that it's using the first member in the structure.
> > > 
> > > But why?  If you "know" it's the first member, just do a normal cast.
> > > If you don't, then you probably shouldn't be caring about this anyway,
> > > right?
> > 
> > This is more about the cases where the member _must_ be first in the
> > structure. See below for an example related to -Wflex-array-member-not-at-end
> 
> That's fine, but that's a build-time issue, you should enforce that in
> the structure itself, why are you forcing people to remember to use this
> macro when you want to use the field?  There's nothing preventing anyone
> from using container_of() instead here, and nothing will catch that from
> what I can tell.

The new definition has a static_assert() in it so it's enforced about
build time.

+#define container_first(ptr, type, member) ({                           \
+       static_assert(offsetof(type, member) == 0, "not first member"); \
+       container_of_const(ptr, type, member); })

That was the discussion at plumbers, Gustavo just wanted to use
container_of() but I told him I was tired of code which assumes that
container_of() is just a cast.  If we're going to write code with that
assumption then lets create a different macro for it and let's make the
build break if someone changes it.

regards,
dan carpenter


