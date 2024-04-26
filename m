Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A81184D
	for <linux-hardening@vger.kernel.org>; Fri, 26 Apr 2024 00:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714092216; cv=none; b=mYIw8oVColVVOtFsjZhf9T+b6rtIDslEZiiatrq3wmLTlWomGg4qxZFdJmTHCPuGM+9g7YWoQ6rgVwk47mANYQDewXJ6mte9V9YxSwlWMBNOs8AKleeMvn8syGCdw9Lp7VDJNl6sHvFO4SVvMDIi7O2m0KC0P9XN75ULh2RzE4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714092216; c=relaxed/simple;
	bh=jx9p20CAKDQvST0OjgmjajVjccrTXQbrwlRHo4enSOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJtAUvSinV4w+ynNBiv0YeuBUTqYo/gUmQqmI0kYlVnyxan9yibGuekWwvV32OE5e3F9uD2bVXenEbqBKv919R2rqBqPDN4A8oXZdhGOM8fM08xpU7lZkfFF96UlS6QVJDQpud31K0p06e6GprOLiGOjpLqaJUfpk9IE/76/lhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Sr2S9k9x; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sr2S9k9x"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5e8470c1cb7so1130147a12.2
        for <linux-hardening@vger.kernel.org>; Thu, 25 Apr 2024 17:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714092214; x=1714697014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ep3fnu+2+kL4NWqqCPxqUe7pdWbO780NggADdnS6QQo=;
        b=Sr2S9k9xgjVUtJHfI0duv8gokAp0wMilh31EeD7cseLdwofZklXhsGCJ3MLML7Ozp6
         ERLSZmIMaGm82ehmTS3UgT4bZZxkvQteO1lqZJPQj1DF1+CCwiyuPDSPVC2MafdFFB5d
         9We9TOmPQVC4eByqx9H8axueo0Sxs4ygu70J8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714092214; x=1714697014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ep3fnu+2+kL4NWqqCPxqUe7pdWbO780NggADdnS6QQo=;
        b=n46b1auj++Wd2ICQ9T1ZIi9X1hJT48QvxSIpolOpwFJA+NvQIcCdg+o04p2sqGfNvv
         4oGHH4gZ9Ja61KPK4yDpQOgSX8QGhEQ+QaZgnrCPzBPvGNU63v0RqTAhB1REJsaQRzkP
         N8h+mMshL31swj1JSKEN4wW4bJsKPsaMypqqiFNvrDwhPUnm8PvLRuPSs0kkMX5rQRFQ
         hzy4mVDYAqlJSbHL9EifZLhPRv0z01XOLCtSKqvJbVpiqwUHVOfsbl74+LtktaJ/6dX7
         p0ldv8zoBtM3+TF7duKzjIIaW3fWyP9CWiK7uFQivx+DKETE/M6NbOcE3IUbRGK7letH
         VcWA==
X-Forwarded-Encrypted: i=1; AJvYcCV6gUY5di/9o8Q1+iK/rke3n9bZ/J5nHA8vtVA5T9E9SmUDDm1BMcxy7aMM+hDTNURfZ4M+A10XNh0/UfBL3ekYq61SQNIkYSQQokSSRNh9
X-Gm-Message-State: AOJu0YxEl9iRSG6qfscTonWDzLSq7bLBR8SoyqVZbgL/MfROyYh+ZGxK
	irLsZCuZWR8mMv8giLbcTEu//w2FtS+T3JsWeJct8LR2JKBN+mAekIcv/ivPBA==
X-Google-Smtp-Source: AGHT+IFfxbYgBOhINodVoPFPMJa26HomFVHpDJJrtFFl/bfOguOV0nbw21PtsctDUa/b4FBbEGMD/w==
X-Received: by 2002:a05:6a21:3286:b0:1ac:3660:4831 with SMTP id yt6-20020a056a21328600b001ac36604831mr1854570pzb.1.1714092214613;
        Thu, 25 Apr 2024 17:43:34 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p8-20020a17090a930800b002a513cc466esm15263915pjo.45.2024.04.25.17.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 17:43:34 -0700 (PDT)
Date: Thu, 25 Apr 2024 17:43:33 -0700
From: Kees Cook <keescook@chromium.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] alloc_tag: Tighten file permissions on /proc/allocinfo
Message-ID: <202404251740.81F21E54@keescook>
References: <20240425200844.work.184-kees@kernel.org>
 <w6nbxvxt3itugrvtcvnayj5ducoxifwbffd7qh6vcastw77mse@2ugphwusgttz>
 <ZirCbPR1XwX2WJSX@casper.infradead.org>
 <64cngpnwyav4odustofs6hgsh7htpc5nu23tx4lb3vxaltmqf2@sxn63f2gg4gu>
 <202404251532.F8860056AE@keescook>
 <20240425164718.e8e187dd0c5b0a87371d8316@linux-foundation.org>
 <sxcyj2gif2avyx2disz62sfe3hot24w4rtszgl2dtqadegtnek@xjkozdbd6yzp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sxcyj2gif2avyx2disz62sfe3hot24w4rtszgl2dtqadegtnek@xjkozdbd6yzp>

On Thu, Apr 25, 2024 at 08:27:05PM -0400, Kent Overstreet wrote:
> On Thu, Apr 25, 2024 at 04:47:18PM -0700, Andrew Morton wrote:
> > On Thu, 25 Apr 2024 15:42:30 -0700 Kees Cook <keescook@chromium.org> wrote:
> > 
> > > > The concern about leaking image layout could be addressed by sorting the
> > > > output before returning to userspace.
> > > 
> > > It's trivial to change permissions from the default 0400 at boot time.
> > > It can even have groups and ownership changed, etc. This is why we have
> > > per-mount-namespace /proc instances:
> > > 
> > > # chgrp sysmonitor /proc/allocinfo
> > > # chmod 0440 /proc/allocinfo
> > > 
> > > Poof, instant role-based access control. :)
> > 
> > Conversely, the paranoid could set it to 0400 at boot also.
> > 
> > > I'm just trying to make the _default_ safe.
> > 
> > Agree with this.
> > 
> > Semi-seriously, how about we set the permissions to 0000 and force
> > distributors/users to make a decision.
> 
> I'm ok with 0400 for now since it's consistent with slabinfo, but I'd
> really like to see a sysctl for debug info paranoia. We shouldn't be
> leaving this to the distros; we're the ones with the expertise to say
> what would be covered by that sysctl.

We've not had great luck with sysctls (see userns sysctl discussions)
since they don't provide sufficient granularity.

All this said, I'm still not excited about any of these files living
in /proc at all -- we were supposed to use /sys for this kind of thing,
but its interface wasn't great for this kind of more "free-form" data,
and debugfs isn't good for production interfaces. /proc really should
only have pid information -- we end up exposing these top-level files to
every mount namespace with a /proc mount. :( But that's a yet-to-be-solved
problem...

-Kees

-- 
Kees Cook
