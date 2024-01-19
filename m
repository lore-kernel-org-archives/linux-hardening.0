Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BB65645A
	for <linux-hardening@vger.kernel.org>; Fri, 19 Jan 2024 19:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705694317; cv=none; b=QuXiUz7tScRkoCWFJL8b7rIo1jo6Ke/L4fKHFOKkNi43RFh1VUpuxwNt7baPwg+i9jViGzyNzJ/J5Y8phJiNPCAK2NIRyRSJxvodF9VSvVJrw8iXtqfws5n3gvoCRs9ydzgnujYaJwr6lDuIlC+/RcZkxMrPyWi4V5Q9tdf0MBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705694317; c=relaxed/simple;
	bh=sThutFEPey5kn1vfPaO+vlKXcAo3DAOcgLqEvPMy/Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iY+aCKtYgvyd/1U6f5XGL7HsdHZgVqW5YkXIFU9MqQodgFAYZC1+l1MoK7qC4tg6OXxAkEEs1l4R+hVI9YLYK4OWvnACBkUk0cjloezoUdid+MWiUg/+SGu7qy1waF4kDmtwxAH3RB2+8/XjHjC21SYo5KTWvUI8sBi/QvnYo74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fD8vZtdK; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fD8vZtdK"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5cdf76cde78so823986a12.1
        for <linux-hardening@vger.kernel.org>; Fri, 19 Jan 2024 11:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705694316; x=1706299116; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C2LfwYsyKiY2dEzfHpNnaI1FNPWRf8Tkgz7+9RYGVco=;
        b=fD8vZtdKgPd/0l8vPCY9s3YMnHwivIPi6pgfnbxzvoLgqrXTE/gG+agMxexYr3lpX5
         sWB4PxeV0nTdl/0FqyE2UuX0Wn9udVw/J6vAWudq/6S5Az8NzAfuU3X8i1ndYMlnvMdi
         onmdzoxFxgWp5qfL5+j1rcqhxa+d0vI5D4+O8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705694316; x=1706299116;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C2LfwYsyKiY2dEzfHpNnaI1FNPWRf8Tkgz7+9RYGVco=;
        b=aZwB03AUAu4iQ0qD+YNOWbnT7Lp23YWJJBXibgMwfwBbkkMUOLW5M+jg7dUfCdG0pq
         yQq3EaHYjJ7HwkR691pOuCYRpHVyboVzfW6wbjkuxq1oAdk8J1ozKd90ANKio6JOFLlE
         wufeWHczHuQbphCUUcRuNXzB1x3QBXpknPeymrUNE2agQjbmU+wlBs7xcfP8TP9oL3jq
         FIOqokbdaX6j+/gHjUnawfFjlAW5ULZDk8r61Fz1v2LN9LsUlCj6RrdLUuixwMDiNqiK
         Ee+P3iyIJMYFeOJNL6rO/6MESfJM6W2WwurriVi0NAowiq9Q8HVnD3PbagYqp8NyBEQp
         iDwA==
X-Gm-Message-State: AOJu0YxXO/hXv/iMNIJxDce6xAuyQRH7iVTYTcKMurhxskMo42Doyit3
	0m1/Iijt1Lykw9m90THq9pmeosB/KNhAG5XB682psGGlI/qUsvhJXW5WMsndJw==
X-Google-Smtp-Source: AGHT+IEyAGGR1bIGI9NKgmfe9mJPaukqKPFviZSxGEnYb0DgSbPfYaWaF1LxDBX4BTna/x2dhOEsNw==
X-Received: by 2002:a05:6a20:da82:b0:19a:8556:8caa with SMTP id iy2-20020a056a20da8200b0019a85568caamr486992pzb.13.1705694315821;
        Fri, 19 Jan 2024 11:58:35 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id sm16-20020a17090b2e5000b0028dd3ac24a6sm4561644pjb.9.2024.01.19.11.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 11:58:35 -0800 (PST)
Date: Fri, 19 Jan 2024 11:58:34 -0800
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] string: Remove strlcpy()
Message-ID: <202401191141.F6902E74D@keescook>
References: <20240118223301.work.079-kees@kernel.org>
 <CAHp75VerSqay6cxRQOihC321BbpAWd_TB6aPigN8XZZ=KPXtHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VerSqay6cxRQOihC321BbpAWd_TB6aPigN8XZZ=KPXtHA@mail.gmail.com>

On Fri, Jan 19, 2024 at 06:05:19PM +0200, Andy Shevchenko wrote:
> On Fri, Jan 19, 2024 at 12:33 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > With all the users of strlcpy() removed[1] from the kernel, remove the
> > API, self-tests, and other references. Leave mentions in Documentation
> > (about its deprecation), and in checkpatch.pl (to help migrate host-only
> > tools/ usage). Long live strscpy().
> 
> ...
> 
> >   * Copies at most dstsize - 1 bytes into the destination buffer.
> > - * Unlike strlcpy the destination buffer is always padded out.
> > + * Unlike strscpy the destination buffer is always padded out.
> 
> While at it, please use the strscpy() form to refer to the function.

Oh, with the trailing "()"? Sure! Good call.

-Kees

> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks!

-Kees

-- 
Kees Cook
