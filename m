Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2A5205AD2
	for <linux-hardening@vger.kernel.org>; Tue, 29 Oct 2024 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730209032; cv=none; b=cAFis2BFpIZNcii53QQyYGBMZJoVbdh2jrTKmFWL2a0oHc0EB03GUmgCO0YnbnFnc42TkhDtec9/s+kCtR3YeolVdtrHznqREiIJ1fCNdssoWK73FbfoySY503IC4WCNIxQyz/rADLZc/ievMansYrcm3e1SnVivM3YgQAqK3/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730209032; c=relaxed/simple;
	bh=Buf8pFNcSxiAlM8W+Pmp65ui4MzMokidkAZZi2O1+KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQ5wa8aXW8zsxeWyo3YJ53P2+7i6Lzs6cOzpzmNX03D1GmPAJCyxoLcbkpGupjuofBAEZPrwn4ehw7ZpTfxv7n6keoj6SzjxkDVHmFO0czmkVCsBHujDDcFC1oFEUZZwCn8OMvPrLUfYGhE/1mgSStL6/dM9fVMGs3WFK0ZE3eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MhcgfcNc; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MhcgfcNc"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso71958485e9.0
        for <linux-hardening@vger.kernel.org>; Tue, 29 Oct 2024 06:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730209029; x=1730813829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4hh5EOww19pBRNBFKTyF3PKTcC/X16iO+VdPl+8FqIg=;
        b=MhcgfcNcOV8ezrW51NwU4HHW4VeJ4XEonZP/yxDQBAb83GILs7iVmznfErZDi/xnnl
         R4LfJW+jR92RI+Z6Gujc+KBn10A22K8rHWpe8uTu7E4ppJqHswBT9Ys5gJHYPR8kM7Rd
         hN09K4r10yQe8suVmc4in8Qzqj2se+ul1lbh4iCbDqW6FtvnKW0TpxSj/A0q5gtLy8qw
         02yvQ+h2L1VHZmmMeMmow6DmquEITuw7r6VG1XBGznWNCCMK7dnIRrjrS4pARbhl/ZXS
         e25/HjkJVL4p9z/w/n00plA0KnoGw2+8QU5l9+PSvuhMz2JWwjdJXAbBf25I6DXs+Qo9
         of9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730209029; x=1730813829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hh5EOww19pBRNBFKTyF3PKTcC/X16iO+VdPl+8FqIg=;
        b=RANQBtqVifCteepPRa7SWBsdabb3u5NCLNO9G67eYdWlTi5Jb3gPQZL90zxBQyLCbB
         fZyNBrrxHHn16xuvwJwY+0qLxrhYWn1ymJQoaooSce5bd6mcAOPDLoiHnL6JQ1mwen/o
         6E9IGOtAGO4P4HXrbJSuughLzs2uCcY9VNDzQJ5lzOTTRhhFhM9A0T4g9z6NzY0F/heO
         uReQQimM0OwVH7U0tmtEISq/NQrLNYRVf7TQYvkUHDrqkSnTXil/fA4zkWQi7N9ojZYS
         A8hoPh/eGYFXLwu9z/BuDLaTdLbRpTbYYMdnSIX+dycYzUITgTy9r7sy9DbYxuRwKhTx
         Diow==
X-Forwarded-Encrypted: i=1; AJvYcCWZGv7Bt4Dviti7ZJFes1gr3nmT8pko5nIxlbAvjRkWtXkNZ9aHdS4tlVKmiZ7D7wwrgW1MKTe+WDgo88mS30Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq9yAnT8cN9FktthGdZVhhOw+XMmQoH1OWmXhxHZoqbSmaGrb2
	x3rth4EPwfb3pQbYs9yGQLdcO+cXJPAETgrYmakxgdBWgCnM6NN5Fa+kfgRzUA==
X-Google-Smtp-Source: AGHT+IGch4QTQwjJXcvKat0hRtmQ+uBZueGwh+G5DA+m6c5CngK7+kfRgN9RkLc99gGvKiTTqX4E5g==
X-Received: by 2002:adf:e78c:0:b0:37d:2ea4:bfcc with SMTP id ffacd0b85a97d-38061172233mr11529235f8f.13.1730209029164;
        Tue, 29 Oct 2024 06:37:09 -0700 (PDT)
Received: from localhost (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b0ed7bsm12566744f8f.19.2024.10.29.06.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 06:37:08 -0700 (PDT)
Date: Tue, 29 Oct 2024 13:37:05 +0000
From: Aleksei Vetrov <vvvvvv@google.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ASoC: dapm: fix bounds checker error in
 dapm_widget_list_create
Message-ID: <ZyDlAd-Z26wnhZK5@google.com>
References: <20241028-soc-dapm-bounds-checker-fix-v1-1-262b0394e89e@google.com>
 <28ade5d1-d13a-4388-bd0b-f03211937abd@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28ade5d1-d13a-4388-bd0b-f03211937abd@embeddedor.com>

On Mon, Oct 28, 2024 at 04:58:58PM -0600, Gustavo A. R. Silva wrote:
> 
> As in the previous patch, this should include the following tag
> (and probably CC stable):
> 
> Fixes: 80e698e2df5b ("ASoC: soc-dapm: Annotate struct snd_soc_dapm_widget_list with __counted_by")

Thank you very much for this suggestion! I didn't understand how Fixes
tag works until your comment, but I've just read about Linux stable
process and it makes sense now.

Sent v2.

--
Aleksei Vetrov
