Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7E5192D9E
	for <linux-hardening@vger.kernel.org>; Tue, 29 Oct 2024 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214900; cv=none; b=HLrZ1vaIiCw0F/wRDQrSqcw5hqhDKvifgLduIV7y7rvB2XHVjgKjuyWA4qiIMLZkXKF+xSByMxJKy+uHGxM3tgWZlEU3erKKLgdr4nF29UjOBMstKrRw9jRLVR1biOX8KQV5ngEQ7v4ql5oTPM9qdlS5tmLk2/MKTGoi+9xQgDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214900; c=relaxed/simple;
	bh=WEVAFJYtA9Y8eRxcAvnLv1yBU6QJV9W9DD7V7ombfd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPUzR1i1Yx9AI9Vi0XJnDxZxd4Ug8nfVvgsnsSSx1hNMFhvgJXvyerdCECHWwZdZyKQ8G7U+zceuTJvGwfg6z3peLVHs3B5BoEhClgf7B4Gco0ODCoejEWeuAzmR9s4vJv5NVVumAuy4ASVl8oJ778FvZM40a4qqMXZeLWmgqrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sk/FAPPB; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sk/FAPPB"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d4d1b48f3so4108592f8f.1
        for <linux-hardening@vger.kernel.org>; Tue, 29 Oct 2024 08:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730214897; x=1730819697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WEVAFJYtA9Y8eRxcAvnLv1yBU6QJV9W9DD7V7ombfd0=;
        b=sk/FAPPBMcanj6XgUuieuWg508jt0negFuv+PV4bmlG01OBOnPpZQGJlk36qdr7YFr
         0J1/6zO6k86Q+7+hwY7z1DI1qggMXr9yWzSX0GvG9c/e8bDQTbGZmAfMLA0on0Zt6lga
         Ilxmuta3u05IARzoERXiVfiwMgDin20efLFw7Bqjc8PDUlCWBQe+3L929VnYHvzfeFN2
         N5p7ymEoAcZyxLg/AWvYn2MrURs0/J90kQF3l3BYGfxApiUcjTXOU/rVO0ATOW4es2C6
         pVin2cIfpZN6HMMqA9loNJvDTYqvk9u7g/w+Nulsp2mEQcqmZr0q8WLgbKoOD1Y9gK9q
         q+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730214897; x=1730819697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEVAFJYtA9Y8eRxcAvnLv1yBU6QJV9W9DD7V7ombfd0=;
        b=NtERc8z8Dp6QicOze2j2BsBIPqMsiPBp9YoxARliBOhhm5TP5B8YvdGDMttThjDO0k
         W+g4C1B5wg9GjIheq32BJWf1pBtnkCOZIv9O6GG/y7RRrt5r+ru33fm8TvNyGQe8pF3w
         tXV6J0oOdKv0c5TLLktdw15TK9IewG9XDoonJxohIUp4NT4Bs+oENsVPYAc4QvGSUceD
         lfToiiz8DMyv/ufELW6VLrpZ/2SwwuhQIP1H0SQcycBwPBKtZzUMRMUGkpUXG86VVRnJ
         RyN04Nn2OhF4TAHR/iNWTFGaAs2A0bc9tS1t1PXH5w4tmUDewmjTRx/sJXPgyHpz7Lfr
         CyKw==
X-Forwarded-Encrypted: i=1; AJvYcCXhQcLGGLGlOePlGKoGsrShzICITGewOXg+Pk85vQ1UyvGfASl5vMK6UVnQ6Zrpu3jtmxNUqhJzldnUtKNwSdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqQa0XUP2+/TXZtDnMmCC3g54rt1TysWLGsGYXE+MORyaFthMa
	eVnoDyPp0BfC/8KBigw0KLHmuY9i8nMJRb9/SxpPIIFX1LzLA9xETIwvFIoX8w==
X-Google-Smtp-Source: AGHT+IEvPtGdVcRU8TyR3DvwW2u3wVv8xHoeVwhinPnFxDCWGaaWXCPAv9qcGbEX9d4Eegwr9M5sCw==
X-Received: by 2002:a05:6000:118c:b0:374:c4c2:fc23 with SMTP id ffacd0b85a97d-381b710f70bmr1760f8f.56.1730214897028;
        Tue, 29 Oct 2024 08:14:57 -0700 (PDT)
Received: from localhost (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b71479sm12702220f8f.69.2024.10.29.08.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 08:14:56 -0700 (PDT)
Date: Tue, 29 Oct 2024 15:14:53 +0000
From: Aleksei Vetrov <vvvvvv@google.com>
To: Mark Brown <broonie@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ASoC: dapm: fix bounds checker error in
 dapm_widget_list_create
Message-ID: <ZyD77Y8bIP3JCAZE@google.com>
References: <20241028-soc-dapm-bounds-checker-fix-v1-1-262b0394e89e@google.com>
 <28ade5d1-d13a-4388-bd0b-f03211937abd@embeddedor.com>
 <ZyDlAd-Z26wnhZK5@google.com>
 <da230ccf-37b6-4e43-be12-9035c594e535@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da230ccf-37b6-4e43-be12-9035c594e535@sirena.org.uk>

On Tue, Oct 29, 2024 at 02:08:32PM +0000, Mark Brown wrote:
> That doesn't seem to have shown up here?

Sorry for the mix up, I've accidentally replied in the wrong thread.
As I said in https://lore.kernel.org/all/ZyDndtgj5vKo-wvB@google.com/:

> Actually, my reply above meant to be for the nl80211 fix
> (https://lore.kernel.org/r/20241028-nl80211_parse_sched_scan-bounds-checker-fix-v1-1-bb640be0ebb7@google.com).

> For this fix I couldn't send v2, because it has been already applied by
> Mark Brown. Guess I would need to send a separate message to the stable
> team asking them to pick this patch from git.

Cheers
--
Aleksei Vetrov
