Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F61F156FA
	for <linux-hardening@vger.kernel.org>; Thu, 26 Oct 2023 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HadBnEol"
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C9810A
	for <linux-hardening@vger.kernel.org>; Thu, 26 Oct 2023 10:18:35 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c8a1541232so10235415ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 26 Oct 2023 10:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698340715; x=1698945515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xw07DRWLKz2p8vG1tYsMr3W7FGieeNrenFoAi4zFRnI=;
        b=HadBnEolRBsouoN5HKIQwrdKGT90ph91wFGZO1Kh5BqVkPACw6uQi6tPd9qfuGP5dz
         CyoAoLWht3zZNY4Gd6Mib7/yZdbWBCsVAg6kuvQRJrw2aJnC9DLN1yzLhSNERggO6nNX
         j8y9WPuWqJUdQ21PwjJL3VJWbH3ZyDOQiocKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698340715; x=1698945515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xw07DRWLKz2p8vG1tYsMr3W7FGieeNrenFoAi4zFRnI=;
        b=mzKn4YLLxIatWSLLHcPJ+jjtmWEAeqyxzvbYKdwzTzRCLjdvy/CA/DToKikvAlrRp1
         7PtENHhEt/9LdbwxlwYzkal0OBotKUH7MpPscRSZuVZ/nApEXz6lJu+HhhYKTKWHcJoC
         TP/7s3jGkNlVpC3TP5yBAbNi+J5ri+l4Rhoh/QwkiGi/HzNoi5wFHEauQkOsPh3kvOny
         imOl+nwoh2zn0lBjOwfiPtcdyS18rNMD/yVMIJKIQb3SFzugydnUdwxttz1d/1OWZrHR
         50wJv068y5rI8niBQQY3vWCg1zJqwmqm3QWdISKRqn2gg+dJWfUg8S2ATbMpIcQ3D3a6
         JWJQ==
X-Gm-Message-State: AOJu0Yx9+PYM3aM8uSjyQuFoJUKHHv49KlyWiVqPRoVW96Rx9nRBJK+5
	VW6ZbrYWQ3jeZJuLKV+PKUUFPQ==
X-Google-Smtp-Source: AGHT+IHJaeoDvNexJ51nTj9W7C9gqugA0dotXJMCxzzBW0CIkG528rxu+gpmgCcu1OYKpZe+Tr0uBQ==
X-Received: by 2002:a17:903:40cd:b0:1c8:7822:e5c3 with SMTP id t13-20020a17090340cd00b001c87822e5c3mr143766pld.47.1698340714728;
        Thu, 26 Oct 2023 10:18:34 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902d50300b001b8622c1ad2sm11228966plg.130.2023.10.26.10.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 10:18:34 -0700 (PDT)
Date: Thu, 26 Oct 2023 10:18:33 -0700
From: Kees Cook <keescook@chromium.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Robert Richter <rric@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sergey Temerkhanov <s.temerkhanov@gmail.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, Borislav Petkov <bp@suse.de>,
	linux-edac@vger.kernel.org
Subject: Re: [PATCH v2] EDAC/thunderx: Fix some potential buffer overflow in
 thunderx_ocx_com_threaded_isr()
Message-ID: <202310261016.2D17ACACE@keescook>
References: <91ec35cd8e2e86fa3d24c2e8ea6970e0437cdfd2.1697908406.git.christophe.jaillet@wanadoo.fr>
 <202310241629.0A4206316F@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310241629.0A4206316F@keescook>

On Tue, Oct 24, 2023 at 04:39:36PM -0700, Kees Cook wrote:
> As the replacements get longer, I would encourage you to use seq_buf
> instead -- it does all the length math internally. For example:

There's some ongoing work to make seq_buf easier to use:
https://lore.kernel.org/lkml/20231026170722.work.638-kees@kernel.org/

Perhaps we can add an "alloc" and "free" pair too, to handle this case:

>	msg = kmalloc(OCX_MESSAGE_SIZE, GFP_KERNEL);
> 	seq_buf_init(&s, msg, OCX_MESSAGE_SIZE);

But perhaps it's overkill...

-- 
Kees Cook
