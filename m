Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01025286412
	for <linux-hardening@vger.kernel.org>; Wed, 25 Jun 2025 15:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750864943; cv=none; b=i9HrZOMY8XNp/JfKSHc6RJxisN3hZqPU2K727U+rkKsCvhi/SZkhqZ3bokSsaU+fa90b+m2RVXToltKK1arDZ9EsFSiSgZ1IkeP4x2oUiAsW54Tr7MRG/SL4s5lHCZ2SXh3fQbG0HcFpqoDFDnWrJMtdfMLvTMJlG7tjRBwUD/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750864943; c=relaxed/simple;
	bh=Rx45NJ1GsFxZHs81wIEDnwZYi+0jDBji5z3WR/l9iG4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Wazh9qetP92SmN4nTDlIxxfHL3kFUtVAN41tqwUn/GMsWFUOUN6HQhQPxnKGTZieDh5Rwywl9Zp2ikTSAkTmeT0ExNUepKOZe7dGUd7Zv+t7kE7pq1EaUnTfeYQHwjPS6w8MA5iZ0yt0UEQ+LMI8KsAefXku+nw2UP3B4AjsqhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BLshFpSS; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BLshFpSS"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-73adf1a0c48so497621a34.2
        for <linux-hardening@vger.kernel.org>; Wed, 25 Jun 2025 08:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750864941; x=1751469741; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyrX5ScOI7JTeYtNbvLaGQids7Z98QDO78XPh4qfDb4=;
        b=BLshFpSSxUuc5XgrjxbiBx9NqFhIf0HnyTGlUbGqPPtiXazAZhP7ijkEpblPZbyOdp
         dOT5NKySSIpBXv2610NE5szYW79xlY0jsdyGPWYNcuzY49D5KO18yQL6nXYR5N5+iIfd
         9V5c8OXsODwnraCD/ZcdVhq0Q/oi0O2/zxtz3pyotgd9/XVsr4vfaUXuAvfXHfdBtYFO
         oQ07ww9kqJbW4WynH3TBZOLeC8UshdU8PqoSYLtZenGfmh2VagthAtObgl0mGAJaGoKR
         PajiTJCRDll8scamE8fIrEYsQ5TuQUEUtB/md2a1+GP/7zQ908JNyjQFP6T21eYJ6kQK
         MzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750864941; x=1751469741;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zyrX5ScOI7JTeYtNbvLaGQids7Z98QDO78XPh4qfDb4=;
        b=oMHsU+yfuaVE3U3XeP2f+PtUbdYcZN9u01ieVcf5DACzo5NY76vkegg3XLrsEhfF9j
         I9Inx3/iEs4DMSupIbfTGkaZrdEeDhB+A97GDlsvFXoLNved+Ev836RyQYYNCJi7MZQF
         jgMMG9q100YSCBi+/TGkBGs1JzSOS+U8o1Fg7UhsoInTPclkSaS/UdVt05K+0aB9H09L
         xWjp+tAPFuqe0d7q+BTW04xEnGQjszN7pvy82776bv5JNCelZAt8tNGU7JK5tzh7GQff
         89439ALZd6fhNAVjjfdEp07pi5jZws4yoRWtTuVMbaRvYOI2RZh4GsXSAVYoqWu+aTUB
         pIcA==
X-Forwarded-Encrypted: i=1; AJvYcCUb9bwC2mlB3nAFl5HylU3CpwsHB/2CEG6+PXchWsJk7tdgobCzh2CxwEbu4iw+oWWh1A0ItcYuluwYI4ujeYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb0lGZFhGA7WJMQw/zmGROlaE1SZA4SNeOFA6GMQY2xA+snz8H
	Lf6MQahogyVcXS+T/2UW5aY6HXmXLFTGzSKo+coGGds8dsrESCkDDJcuvtB0hhUFl5CrFXTyxLN
	SUI5d
X-Gm-Gg: ASbGnctXycrsUEe1oAGvDt0qHnWBHUFK4+0JI6NhMe3pE+EuJ6oCMlHjDw/1rVcNqiV
	mcj/FGGVPl2D21baMpmXtfG+zksSWnuB9RJG+23kTZ8/ctGdQfGAFmUNfhiZGZrD1tUJP8qoxDS
	1OLgOqImndv7xc+R8Es5h5HgHLu2RGc6ijywPYeppPPjxlVNRojpJ+MDzLQFPdnItfikYgeVO98
	cr0OHLN4vkGbeGWDRJ3OKuJxYBBP/+jzuqeTWv0ZtixAFW6TznKFUOzuRnXnUYKslVbefS/nQ0L
	s/elQfIYGNwbqr11Ohp+LXQDW2D+OVCA6kQu6H45d0HQIjM58xXr9vYzP/LEPjnwipmeuZWyhaH
	9wNh9
X-Google-Smtp-Source: AGHT+IFgvZOS7uRZ5bc8Wzr7uLQERVpIcqLu7N7QwQiQgNpOzZjzTb0IQiQzFQyoW2dE5XA6Bc3lRA==
X-Received: by 2002:a05:6830:2112:b0:72c:3235:557d with SMTP id 46e09a7af769-73adc7b4318mr2332490a34.13.1750864941059;
        Wed, 25 Jun 2025 08:22:21 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:1fca:a60b:12ab:43a3])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73a90b1b627sm2232339a34.19.2025.06.25.08.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 08:22:20 -0700 (PDT)
Date: Wed, 25 Jun 2025 10:22:19 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: thomas.weissschuh@linutronix.de
Cc: John Ogness <john.ogness@linutronix.de>, Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [bug report] printk: ringbuffer: Add KUnit test
Message-ID: <eaea66b9-266a-46e7-980d-33f40ad4b215@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello Thomas Weißschuh,

The patch 5ea2bcdfbf46: "printk: ringbuffer: Add KUnit test" from Jun
12, 2025, leads to the following static checker warning:

	kernel/printk/printk_ringbuffer_kunit_test.c:91 prbtest_check_data()
	(unpublished script worries this an off by one)

kernel/printk/printk_ringbuffer_kunit_test.c
    83 static bool prbtest_check_data(const struct prbtest_rbdata *dat)
    84 {
    85 	unsigned int len;
    86 
    87 	/* Sane length? */
    88 	if (dat->len < 1 || dat->len > MAX_RBDATA_TEXT_SIZE)
    89 		return false;
    90 
--> 91 	if (dat->text[dat->len] != '\0')
    92 		return false;
    93 

My question is that the prbtest_rbdata structure is declared like this:

    53  /* test data structure */
    54  struct prbtest_rbdata {
    55          unsigned int len;
    56          char text[] __counted_by(len);
    57  };

The size of text is not really counted by len, it's "MAX_RBDATA_TEXT_SIZE
+ 1".  The condition "if (dat->text[dat->len] != '\0')" is reading one
element beyond the __counted_by() value so something should complain if
we enable all the debugging, right?

regards,
dan carpenter
