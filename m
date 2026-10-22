Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792651755;
	b=ZUK/rxyMFjdTaFgsxpR410Zud0TLR6jLuxNgu29OHJOyodCMD9PYjVFsmTSO8ynRAopN
	 a2OpUhLf0aB45+5Sb5VTopMCPABm9xv3yS8RwEppx/kk7ABw7C5aoUwIeHYOxc3YQPFdd
	 5yL0QV3EYcTUSAPfDQCaxXQA5AGGNmqSGKoqyjksKUcA2RIt81akC4NtA3m9YpMXZgUqx
	 vVLmiely6JmyC4GA+6tikSTeUmh3IuXIF9oTvHIoyt+/3B7XZlj1Y1u3et6bdksH1rQLn
	 KyNfHlKoaVxzQDjm2l9O7DP8Or7ezfFfDW1vH4H3d9tUVy1nYOrQF72A2RFJKIipHXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792651755;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aOnKxbhQNH1eTmeBnjETvVZlJB22FsVUKhxUnQp3P/Q=;
	b=UdOCHXf0ROLrdnqcq/+zn6oPjZYKDYysCaEcvRg54Yt0Rfp8EsamnclUvw2tstwHcpej
	 q4/+kxFVKhV6sY3YWNRpmTYRQhNkvoyX9g41AUHnQT6kL66eFGP9/pjciEWmn4c8oq/zk
	 XJTIJthb/l2i/t18c8OoeCradHYB7gMOE0KBDrUh+2mWhC/wBCUR62KCK5PNZz6pd0d/Z
	 Wr5bhyp1eF9J5B+sxQrdbtpnACu5n0d2Ryhx5rGK6o0ID/is0l9RaqAgOIrXZcWPmO0ao
	 br9MrBiK+ywGHuIUk9ny01RoOpIErCsnQwa6IKCcQIvbULyTG9lu4WldoPN66nXvxEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D0MWwbYm;
	arc=none smtp.remote-ip=74.125.227.132
Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4DB606A31B
	for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 06:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B4DB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D0MWwbYm
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3a84a12aa97so437207a91.1
        for <linux-hardening@vger.kernel.org>; Wed, 21 Oct 2026 23:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792651755; x=1793256555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aOnKxbhQNH1eTmeBnjETvVZlJB22FsVUKhxUnQp3P/Q=;
        b=D0MWwbYmQfuUWSye7rIUiVQ9YWomoQdyoRDN9rrFjnN6XHjz+UIgna9JlH9IBcAYMh
         rUUqjtC3qFMre85uij61NrdbkTAZEKQf5tPylE5P++bkOSlYpCctsQ1G4I00M19inpZF
         e6MPOIDcqmm84ygIFvHV2zMS1l8o1Z5DDrAwdtkjXK9xiIZU3/SJuKUadtlMZCHB8Jdl
         SyZeTze1oZiWYqtjfh2HUdYq0uqwT4nOLh12ZQRrNvp0at+WkR6SuB4Lu7Ml/3cBvd29
         K5tkvBDpSzU40DIKRzfVXDE/iFFCAH5upLK0fBtZPmQrK32W7lq001wJmChnm6OMnDd7
         dzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792651755; x=1793256555;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aOnKxbhQNH1eTmeBnjETvVZlJB22FsVUKhxUnQp3P/Q=;
        b=Sh8jANcpdHEK00N4apelGHNoVOUfql83JsHKFMJyNOo7Jq9hsqmVtZRzU2BCmgeT0s
         C7HiCrK/JR/5nqSY3aoDryh2GPJNL4JTouxh6Q/NWGiJjFD5jexQs7uQNqedPqN7McNM
         Uxd0q75QOwy61TxyiGc+WkIU/VvakFXSDYpR+QLMGSnTElRW7KQ7FlOXqDRf8Pb2zmnY
         /i6ScezFTKYMlEkd190rk4CsT4pbbmTgbrH/s/t+MS1W1ysYBz61MuHZNmzzcJt9jbsn
         twS7vK9mKoBETeZKmRH1sbd9YSYa28+GcDcsD4bp6d9AHSBg4k1Q+MZ9vCw4Iq2e0OcQ
         Ry+A==
X-Forwarded-Encrypted: i=1; AKwUvBxRSJpMBLcaGZSC/QqffRr+MkSOc/r9/+nbI/j+sh6IDBp9zTlbY1Hy63AxXp2wZWAtUYT7G+MRv37MosYW9gk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIOpzRHW6fY/3O6veeCzwVc+sb0Xactj7KlUw0mN9wdcbEjKFQT
	+dc4JrUJjUwyvNv54iWwL6v464GAt2hq2jpS7tEX6fSl6CjUlh34RKtd
X-Gm-Gg: AYBFou2UwjkKgomUcuDwYXPP8FnqI7QRpO7KXryWiTA9H+dDnjzHZiGg6KWUp/ThpDu
	ji0PwdlGvQaR6CLQOj6mC3nHhITmMZUjn5z0wat8KgqBh2ZCWv6AEXLVXwM7WhjyPrMX+We5Qqo
	jDfSH+bV0cypSyx4GuuBnvbuJ3pPvj4zc80ukwOxydvEyUkVjsALpXY+Zi2FI/eqnLkgyhfm8OM
	GKrYg6cu3vBmYomJP0Q0FNAJAokq2bmGoEyfJVCaQ6DfKWqBNHUxYi7zV2VfQU7teLYGrRS614y
	UXa2URPvTtG9WSH4yZJQSmoSpTYFCmVPyIH03ayS51SQmdE+Rzu9EFxuX9moqSTtD96NJ2pw7av
	VrVbFWoZ9iJ5L1xyXo8KoPouhF/hh7Ho7KqxcS6OL14f14nRcn0Gjp1XuHqJt85SAJ0GkNSviyk
	U+qOVaz2D96LCT5tk1Kt1HfMLlU444w0tXHF9mmjzKJ6B/5WAeKDWps9XTWn03ZVpiw9XgwIp4i
	gs4pcwGvAiqpG+qsxt2RFqeBjfzdzs3A4ggIi2y30JEiJYMJi5IXCy0FtNRGeQU5SGOm+DJUbuT
	XSOwFmU=
X-Received: by 2002:a17:90a:f944:b0:3ad:1b0b:1246 with SMTP id 98e67ed59e1d1-3ad86d5238fmr3509934a91.32.1792651754537;
        Wed, 21 Oct 2026 23:49:14 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada49314besm2707437a91.11.2026.10.21.23.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 23:49:13 -0700 (PDT)
Date: Thu, 22 Oct 2026 14:49:08 +0800
From: Shihuang Liu <shlomojune6@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-input@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ville Syrjala <syrjala@sci.fi>, Henk Vergonet <Henk.Vergonet@gmail.com>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] USB: add usb_make_subpath() for formatted device
 subpaths
Message-ID: <gih6jsfknkjemuk5ahmmpxtzp6ymyynergxckpmxfbbybzpdc4@me7k7j472mdu>
Mail-Followup-To: Greg KH <gregkh@linuxfoundation.org>, 
	linux-input@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ville Syrjala <syrjala@sci.fi>, Henk Vergonet <Henk.Vergonet@gmail.com>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org
References: <20261021123146.17202-1-shlomojune6@gmail.com>
 <20261021123146.17202-2-shlomojune6@gmail.com>
 <2026102104-audition-unbraided-05d1@gregkh>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026102104-audition-unbraided-05d1@gregkh>

On Wed, Oct 21, 2026 at 05:20:31PM +0200, Greg KH wrote:
> On Wed, Oct 21, 2026 at 08:31:41PM +0800, Shihuang Liu wrote:
> > USB drivers often build device paths by calling usb_make_path() :and
> > then appending a subpath. Several callers use the deprecated strlcat()
> > API for this.
> > 
> > In preparation for removing the deprecated strlcat() API[1], add
> > usb_make_subpath() to format the USB device path.
> > 
> > Link: https://github.com/KSPP/linux/issues/370 [1]
> > Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
> > ---
> >  include/linux/usb.h | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> 
> Did you forget to use get_maintainer.pl for this?
> 

Sorry about that. I'll resend the series with the proper Cc list.

Thanks
Shihuang
