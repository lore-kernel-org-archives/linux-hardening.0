Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D53133987
	for <linux-hardening@vger.kernel.org>; Thu, 30 Jan 2025 06:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738218203; cv=none; b=G/978OzeMkLw7hqISMUJmpHmFY/kbx+AeMTpOApfvhN+nbKCJxNsq4wlkVxi2PBcyJhJQjJDESgDpIQuSOqfRlSZcfj9giuFzlzUKYxIKVKHmNW9qd2rlyZfSSuJQe4YNvDMueKHdi7nx8FDPxwI6XYpGM/smeamAQ2CoFr2cTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738218203; c=relaxed/simple;
	bh=G2kowd7hqmezPOY8+BqMZm1IdO6UCuJaE23GWarr+sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0/gwkY6S6jkgj+TvvMtmNDCbdaT80lbsiCZcyOVGwDu0Cfi4GeL8R7igObgELmQoeSK77FHwHj2CyTGa2ULKoBNJQz/G+SQAEiEnnIRd16r4jxn5D89yxBkWixSZRKJytyFYIGh5DzBap5EKUelm+aEHLYRg7tRRBKi2EFpQLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A3jpLpvK; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A3jpLpvK"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43675b1155bso4310625e9.2
        for <linux-hardening@vger.kernel.org>; Wed, 29 Jan 2025 22:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738218200; x=1738823000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YFJSv3KcxO1VvnZ6+6jaqsugVtVSQkL6Yvtf1V03Z/Y=;
        b=A3jpLpvKpVgtGDLY0mCqrzi2UkpbA5a9QDjZi+GGKeJ1WpEp0QNsrH4/E3e6Y27DOm
         bmK1sxTpgOiEJpgYhq6nxSLIYlVHH0x4r3HRASclsN0L/t/CO371EWWEZk3TzmwlhlJ3
         mH97Vn4aewq4YTwTImUjZtkIEvI9b8Kob3KLX673EiUg9dSEZ19BJCCfHGTw5xNK66/f
         CqnjNBmxLCtcNtn03XwVQCWIf4Rq4mp/fLin/APH30DDvq8a+K340xbQfFX95JEZJG64
         FjIjhKUb++LiOLO01Cdk9JNykGlejnciAAKJi+JfESfXsaUgSnW7VOAn6MlB0/IzidwE
         ZKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738218200; x=1738823000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFJSv3KcxO1VvnZ6+6jaqsugVtVSQkL6Yvtf1V03Z/Y=;
        b=f6/hAFUM6sPL9AC7/IQvthKHPrhCAPa6QOgyFGW7THgVclMRRsj5Q84+S7jiDYUpHH
         7cAOJ+gmHsJvweQg2ED8wIoJS9WLqX7XuhEZP9+ZcK0qxtCGsG8aXuUMHjA4ngE5K982
         PLtp69Pz1VZlVvcRiswrvcYIbD4bu9PKPmw5fGGNKguNw/a2y++OsUpzRi5KIqrcxy5e
         OAT8zfQm+m3AAqN45+8YKMmCTm5TUoC5AcTBMAfCEHzSnRUC5+Ln0qYdTUxI/xhlgukl
         jb94L5CTflVbINGoC0Qn4q//M27Yqr/h/Qrs82tytw6vS3CFlj7nED3jQVZVCVh+2RaY
         vppQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4rqn35RI/yU6AnbUiOub56mvkWsm6gOuE/nI3FslpmftCim7XIhcAOzNlo7a5xIDBX63Y7fghAAOV8nukpMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwc6jPOuvzSyNS0g1f/xyjpYI7inF9AQB/o+o7dEk2xGEY3iXT
	FuwsQ7DYtoO0yvvz/nxegkmdFdJNmMfo5X7cFm3Q3DB/5IXaYP5DqAO5iaSKEdw=
X-Gm-Gg: ASbGnctZzmsqD6BrvZv/qBvXP4POfDL0KveYfBNvTvh4FLrQGGof9xYhBqSpknil0v7
	ennFiRK6Dk35/nN+t46u7YT5La8NvD2n1xDuWs3G+LoPhUPkdY1SAiqP+69p42clXiMODoWY2sU
	1ykIhNEkupe/+ypenuB2sSdTvZ4K6p07ndujrvePlBsOlpxNX4togzWoKTorRNX0GG1oYll5uSm
	GP53v5OTcWqauatRKAoKaCC1A1XxRB9oC2RVSw+1pLm6wIT133VrvzfWKnAUcsCnKcGNVxwTWDJ
	dSvGPqb/n/LJaSGDlBHf
X-Google-Smtp-Source: AGHT+IH/m4duPhbnZDGM9j7qzQFtkclBdAlrjtJmdXn08GWPDaO+PkGQ2IQYePEgjkJRgqobq8KN3A==
X-Received: by 2002:a05:600c:470c:b0:434:fddf:5bfa with SMTP id 5b1f17b1804b1-438dc3bb395mr52760795e9.2.1738218199634;
        Wed, 29 Jan 2025 22:23:19 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc2e384sm48025585e9.19.2025.01.29.22.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 22:23:19 -0800 (PST)
Date: Thu, 30 Jan 2025 09:23:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] container_of: add container_first() macro
Message-ID: <ca7ecc46-5bfd-48f7-9011-1b3fa48153a3@stanley.mountain>
References: <Z5m76U5zh34WbeQY@kspp>
 <2025012955-hypnotic-patronize-8931@gregkh>
 <f6e24dfa-450e-4de6-87a6-6fcf7d83888d@embeddedor.com>
 <2025012921-dense-unplanted-952b@gregkh>
 <06aa1194-a7aa-4a5a-adb8-f6cd447d35d9@stanley.mountain>
 <2025012951-plenty-clang-1e2b@gregkh>
 <3979f87d-b7d7-48bb-b6ab-cd8165dbc3cc@stanley.mountain>
 <2025012940-hardhat-usual-fbc6@gregkh>
 <7f165e66-a0ff-48e2-a3f3-d5405a66c867@embeddedor.com>
 <2025013030-unleaded-answering-165d@gregkh>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025013030-unleaded-answering-165d@gregkh>

On Thu, Jan 30, 2025 at 07:14:01AM +0100, Greg KH wrote:
> > Anyways, so far so good.  For some reason I was under the impression
> > that you two guys wanted the container_first() macro.
> 
> I don't :)

Greg, container_first() is like peeing in the shower.  Once you try it
you'll never go back.  :P  Anyway, it's not really related to the work
you're doing here so don't worry about it.

regards,
dan carpenter

