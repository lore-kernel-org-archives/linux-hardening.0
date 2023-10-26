Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4371BDC7
	for <linux-hardening@vger.kernel.org>; Thu, 26 Oct 2023 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LeO0za5t"
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B3710A
	for <linux-hardening@vger.kernel.org>; Thu, 26 Oct 2023 10:21:42 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cbf47fa563so10180105ad.2
        for <linux-hardening@vger.kernel.org>; Thu, 26 Oct 2023 10:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698340901; x=1698945701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hw++taqiAXJcJaevbl9Amw4ktPoTvoXuDaFGZEL0LMc=;
        b=LeO0za5tAiUlysaCURGdKsibnH5is8GpLUJWX9TrDP38vZBjsz1tKYme3QUvMrucYa
         8Wt8r/aXcTEnUBrasmOVHmlTQONzCbYwbJPxJf7zogHaj66UbVz617xa8sebCCPn1wr9
         obd/zMrLKPcHFeqt/cu0zmv6pItofUuJNjT5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698340901; x=1698945701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hw++taqiAXJcJaevbl9Amw4ktPoTvoXuDaFGZEL0LMc=;
        b=PDSk7UWjbPzIYNwVo07aBlV5wKEiBHm/lkDZ8MpM4J2pL9Yv6JE0FEHIm/4qNRr4Ft
         +4YOpNHOMCcd8jJUdRq+H/VOhl2nI0AMfYCwoILJSrC67m3JUnBKRNo1Ill6ZeOer7Nx
         kbHQw5cp0sHipis0ZMOXy2AJk8lr/WqGgWU85ydAdCH2mCb7i8FWOYr9adhoEXa6cwsc
         VzfgSZ98ndR2dX53fgpQQ78w/mvuoEX8j2jkCCPFwhF5P72RdCVHVviRpa2gOz49RJvq
         DzxxVPAU7Tvotokh5EDiMP6e4jMR2rYB8ZZub7VSb4QvkWrzWU6ThPKMJypT0GwtLWeD
         JUVQ==
X-Gm-Message-State: AOJu0Yx12APGWjqjWS7FmZjhGO3CBWoy+/wt4VOMpKiIyNRLN/gUw5P7
	smUXoIiqJndOiPosBNOIaeeJ6Q==
X-Google-Smtp-Source: AGHT+IHLci2DTytmV/JdBaItNFV0GuBlIsEY5ALqpTGTgm1IFXlRUZZ0zzqUWLU33lMHFwbN6G/ZBQ==
X-Received: by 2002:a17:903:1ca:b0:1c9:d6f8:1902 with SMTP id e10-20020a17090301ca00b001c9d6f81902mr204408plh.15.1698340901297;
        Thu, 26 Oct 2023 10:21:41 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902704100b001c61921d4d2sm11241779plt.302.2023.10.26.10.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 10:21:40 -0700 (PDT)
Date: Thu, 26 Oct 2023 10:21:40 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Arend van Spriel <aspriel@gmail.com>,
	Franky Lin <franky.lin@broadcom.com>,
	Hante Meuleman <hante.meuleman@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	brcm80211-dev-list.pdl@broadcom.com,
	SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 2/2] wifi: brcmsmac: replace deprecated strncpy with
 memcpy
Message-ID: <202310261021.B86F566@keescook>
References: <20231017-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v3-0-af780d74ae38@google.com>
 <20231017-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v3-2-af780d74ae38@google.com>
 <202310181654.E47A7709@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310181654.E47A7709@keescook>

On Wed, Oct 18, 2023 at 05:03:02PM -0700, Kees Cook wrote:
> On Tue, Oct 17, 2023 at 08:11:29PM +0000, Justin Stitt wrote:
> > Let's move away from using strncpy and instead use the more obvious
> > interface for this context.
> [...]
> So, this change results in the same behavior ...

I should have included my r-b tag:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
