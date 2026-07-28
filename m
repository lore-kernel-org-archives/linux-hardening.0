Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6050541B8E0
	for <linux-hardening@vger.kernel.org>; Tue, 28 Jul 2026 09:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785231606; cv=none; b=DIuyDHjokRK/Cciqdn5UbyDQf0Y+CSmZ+t+baEFqA68RMJ7y/Yp4B0NtPUx3jMSKYcuoIQLz1wbG6QT/KI7UVEHA/DFDlQFNooqSW5DTCjya7G4pAtTzvNAm3g0PV8JjZmKnkAVPoNkiBxdWZLYmb1JGVip59FB7JpKoOME8d4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785231606; c=relaxed/simple;
	bh=RXCi80jJJoeuiTYlNE5Vyy/b5imzD817AWX8SLHt5ag=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgArdGX+MMKnIsIVdpy2NIOO6birKs3ZQRbyhiaLiA4AYHW6ldW/8br+omcebRyJryqPdZC9sHUwWKp4Y/W6ws3CIdfQ84Z/jxbuybFNKMLKLCoJJQDXVXV4+EX9Cn6K0M5UM6OFYOEyvmU6GqNvlqoVtqIB/dTbe0DuF7spD6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvbZsnVX; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvbZsnVX"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d004f135b1so18634515ad.3
        for <linux-hardening@vger.kernel.org>; Tue, 28 Jul 2026 02:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785231605; x=1785836405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hK5fMzgWYkoFa9TR120mfcDFY/khLZ9IPeK5ODLUBiE=;
        b=hvbZsnVX5J3ttTe7r2oSG6+7m8tYw85La+texAnlV+TJs1kYGTU8Zw2HFcMYCLuVSp
         sKhmw8COywGecMh+5ZffZutV95agPgU0PyKCf3jSTbgcYclwRR/+EYEOKJlEly5H/ear
         J4IMASIPa3OU+hR+MNaAuX3abl9MMRz/bgBlZmhm3vIRHfJe6i3c2kxE/wVHt/1cyveq
         74MKs05iAkbPH1M+W86Htqf9sz/+EXb2nXYjmT2NCl0OG+8UCtSqfBmHKvC3MJWYdhsI
         Vq80nY+5C2UlNzE3sQ08ZaeQQfuP/P8DXymIeU+JkPb43sGHGmUXrGg+ATxU+KzP1zfQ
         yIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785231605; x=1785836405;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hK5fMzgWYkoFa9TR120mfcDFY/khLZ9IPeK5ODLUBiE=;
        b=X8mfBUiDuHGQiJ4y2V35hexvfiEvrHCQOeog75J6lAxT3j18LAunVdhzQgQO4h8+/o
         Ugr9RF4CoLr3vsnEhCUOl+cgjbYao3fQwJ1NY7h4pqyuxryCBFzqdLMHWF2Vcp95uq8j
         BfOgS1RbH6oQLKyWg1oHw6hKAU1aOVGYL9IlQ0QdvGysVaspuvnryuGUitpNh9c4dHIE
         KK3VxvchAXKIbf6fNMXPxfmyv9vRths/hX2APjbNg+mnhEwui4qukqC7zXXdk9g9JE72
         TJEmThzS8uOIqKu0Iy+XQBhQ4Xo7Tj0pwBxE2YgjYhWPxbkRiXc/p8rKGNoMki8ieUi/
         k1JA==
X-Forwarded-Encrypted: i=1; AHgh+Rp+zGt7/cOlt+2I8cNH4vASCmrnPRjx8IP3bgG1Ty5SbAK7QQ4CZA0+lskEbpKJc80C+USH1habujYP8jmIhZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3fEKLoi6/VWUS58y8f6Sw/B+5HE8yvJqm8GwtLZAOoOw+4McZ
	MBe3826G8bkgnE/XGHnDiQ653fL3z4bsz7NVnTBZzE523qh8Iw5aafVpN4PCICtmqEc=
X-Gm-Gg: AR+sD10Sq+WtIVv7kIxccTbYKh6tJLWVVY/S+nEs4hns/dvUHRS8MXFYfWLrSQ0aUYx
	BVqppXdRjwTVpHszCbNJAAOeKLJINHl4aPJ68xB25/vW6Btd5JvA+vi6DgddeIpKNcvT/bLi282
	Y19vh+pEwfvt2Pp0zXQf3nkE751aiz6tYZaC7xZponX2aiWWGJzmmesal833jFKkEzWNkWD+GEx
	q55P+hQYJVEPqt92HM/xqPV+I1n9Del1s5u0sdsfQQAHirUMTAudwp1WskJYeVcMfgnFxC9K+r4
	A0vSePJcf8DJboTiWuCe4a8ESh+H3YM6+nFUhM4NC4f5aT+/SEXLRCGp8osVOoXIVx6R97C4T24
	7JAhx04K1xfDdRGTIWyWfB0Mp+ayvtGOgZgNHf2U+NWOC5fZWApJcznKk6sVj7TLeLUYzxQxpTN
	IN8ocOShFlFZQV8XvjU+E+hJ/OuAMEnvzStlfSznNr8G+EKDWdh8ADeMscHtiAbxM5hcmK6DIUf
	uJXd2o=
X-Received: by 2002:a05:6a20:4324:b0:3b4:669c:ee32 with SMTP id adf61e73a8af0-3c8ba5bab93mr2125489637.37.1785231604622;
        Tue, 28 Jul 2026 02:40:04 -0700 (PDT)
Received: from nxpwireless-Inspiron-14-Plus-7440 (61-228-203-195.dynamic-ip.hinet.net. [61.228.203.195])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb660deeasm4328676a12.3.2026.07.28.02.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 02:40:04 -0700 (PDT)
From: Jeff Chen <chunfan.chen@gmail.com>
X-Google-Original-From: Jeff Chen <jeff.chen_1@nxp.com>
Date: Tue, 28 Jul 2026 17:39:58 +0800
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes@sipsolutions.net>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be|_ptr)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH wireless-next] wifi: nxpwifi: embed rx_reorder_ptr
Message-ID: <amh47u3hQRDO2dAG@nxpwireless-Inspiron-14-Plus-7440>
References: <20260727002916.117754-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727002916.117754-1-rosenp@gmail.com>

On Sun, Jul 26, 2026 at 05:29:16 PM -0700, Rosen Penev wrote:
> rx_reorder_ptr is a dynamically allocated array which is done near the
> main struct allocation. Combine the two to avoid freeing separately.
> 
> Also fix the type to what it actually is. void is normally used to avoid
> casting but there's no need here.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  .../net/wireless/nxp/nxpwifi/11n_rxreorder.c  | 19 +++----------------
>  drivers/net/wireless/nxp/nxpwifi/main.h       |  2 +-
>  2 files changed, 4 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c b/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
> index c5819f89b08c..b2fd624497a3 100644
> --- a/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
> +++ b/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
> @@ -171,7 +171,6 @@ nxpwifi_del_rx_reorder_entry(struct nxpwifi_private *priv,
>  	list_del_rcu(&tbl->list);
>  	spin_unlock_bh(&priv->rx_reorder_tbl_lock[tid]);
>  

Hi Rosen,

Thanks for the patch.

This patch triggers an unused variable warning since the for-loop was removed:

../drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c:264:6: warning: unused variable 'i' [-Wunused-variable]
  264 |         int i;
      |             ^
