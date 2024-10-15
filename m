Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBED11B0F02
	for <linux-hardening@vger.kernel.org>; Tue, 15 Oct 2024 21:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028053; cv=none; b=CHaSPlHnd/RGF4P4gLdlG4XKOH+2W7I5Or5yQJes9V27f8acC+BVk2nf00hcWZFKe31u97KUsyXAT0CEzXtF1qbLTv/QZXBhSRyFxM/PSAWMiK4BcgyD3Pf+DZBnZxGwvH00pZ61AasZc+o45rHIORlTgZSJGDXTNt6JT/5n92k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028053; c=relaxed/simple;
	bh=knTgNecEkYKeM/JJuIkK3FnpRRBOBT0/xY6PnfCDNgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goHo4ANyYgjMUdVCDbrMDNU/dZ6MZHUFuY3xus+ddt1NxGLjlu5ZB47rbIYWinXdnGuBctfYpxEJtdbXelw+Snk8xa8ZygchiofX0773QCbLjafFi4LGhf8B/fMuZuDK0LTTAvIECbhPFC+xMSjl+HgG6n5VJGCB9GXcvZqQVOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PtWFFG5r; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PtWFFG5r"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ea7d509e61so1240667a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 15 Oct 2024 14:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729028050; x=1729632850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DKjBORgdklEf0VcX5F4hTKcBGHj5kwXdCtAfdZCcB54=;
        b=PtWFFG5rP5EVlcOQHNmvJwMM5bZKj2qn7HBXaBvmSUg4cdzcDaaESuhDNjkpfF305g
         /JZowdpoi/ZfEWNqjPw9IA6vzW1IaNC1/mYdQMy49BztjFdI0zGz2AR9kSVMVXEz9wyi
         whUh6BatT7C4yEVnAMc8Wx35VLWfRM2924oxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729028050; x=1729632850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKjBORgdklEf0VcX5F4hTKcBGHj5kwXdCtAfdZCcB54=;
        b=mVMLK0Sx/c35M3NU08RUSdlcDNy7HGnsYpYqCKMCbsgIEnEqWil1rqSAkXHk3us0qW
         aQdvSeacvTAziXxwG2c4998M1w7ILL9vX7Pem5/UngVn00bijY92NJDI4H11XkhXiwpi
         CuVWlLXt4L06GrpMBWg4XegHZue/6PF0HalVW4Eo2kjuT3QUjOklOldpT0lCs/L17jkj
         gVrEm8U1q4MkDdbta1HfcaBjH/meYOwZEr964uGRcrqpqQA2aBpwyNQUyxsKtE5y1MLY
         7IOwm6DIAAWfb1t80MTNQKNWyO4sr/JXO2vG4OvGaqBtkShSr7XKvm5w7AbaTtg7tsJA
         Xiig==
X-Forwarded-Encrypted: i=1; AJvYcCXDd9t5Ggau3fH303flXcV6iHz0e+d7GyDrhvqgYmZLglpYfzzUgXEoTBoO5y4mY/RDj0Muyqz/YgEYRqgJsFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBW/FtNvIJdWzUOd/UthCkIDBt4VflRPffuyOLe0I75TFUw7qL
	uVp+I/15jL4RaCBzA0yjiYgr/AN/D/u0jnx/+dMIOcf8wOCkBiBfkXb5Ne9rEg==
X-Google-Smtp-Source: AGHT+IHRze0IzcATBijgCp06ZoOiRkVXgkxhi7l6ZEkczzicwWYspql4/Tq/D7z2iq5VXHb4rA81kw==
X-Received: by 2002:a17:90a:b017:b0:2e0:ab57:51ec with SMTP id 98e67ed59e1d1-2e2f0d7c939mr19519508a91.30.1729028050216;
        Tue, 15 Oct 2024 14:34:10 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:eef3:dbf8:fbe3:ab12])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2e392f753b4sm2409874a91.49.2024.10.15.14.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 14:34:09 -0700 (PDT)
Date: Tue, 15 Oct 2024 14:34:08 -0700
From: Brian Norris <briannorris@chromium.org>
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	Kees Cook <kees@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	David Lin <yu-hao.lin@nxp.com>, linux-hardening@vger.kernel.org,
	Kalle Valo <kvalo@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/2] wifi: mwifiex: Fix memcpy() field-spanning write
 warning in mwifiex_config_scan()
Message-ID: <Zw7f0FTlGk__kE6e@google.com>
References: <20241007222301.24154-1-alpernebiyasak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007222301.24154-1-alpernebiyasak@gmail.com>

On Tue, Oct 08, 2024 at 01:20:54AM +0300, Alper Nebi Yasak wrote:
> Replace one-element array with a flexible-array member in `struct
> mwifiex_ie_types_wildcard_ssid_params` to fix the following warning
> on a MT8173 Chromebook (mt8173-elm-hana):
> 
> [  356.775250] ------------[ cut here ]------------
> [  356.784543] memcpy: detected field-spanning write (size 6) of single field "wildcard_ssid_tlv->ssid" at drivers/net/wireless/marvell/mwifiex/scan.c:904 (size 1)
> [  356.813403] WARNING: CPU: 3 PID: 742 at drivers/net/wireless/marvell/mwifiex/scan.c:904 mwifiex_scan_networks+0x4fc/0xf28 [mwifiex]
> 
> The "(size 6)" above is exactly the length of the SSID of the network
> this device was connected to. The source of the warning looks like:
> 
>     ssid_len = user_scan_in->ssid_list[i].ssid_len;
>     [...]
>     memcpy(wildcard_ssid_tlv->ssid,
>            user_scan_in->ssid_list[i].ssid, ssid_len);
> 
> There is a #define WILDCARD_SSID_TLV_MAX_SIZE that uses sizeof() on this
> struct, but it already didn't account for the size of the one-element
> array, so it doesn't need to be changed.
> 
> Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>

For patch 1:

Acked-by: Brian Norris <briannorris@chromium.org>
