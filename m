Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAAB85275
	for <linux-hardening@vger.kernel.org>; Thu,  1 Feb 2024 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810720; cv=none; b=duP/A8RSnLK7LzmZOPAn+tPd0Y/Iomnz9dTJWB2HSwDbFq4bl3MJQeKaG/eId634wZetSU9CbNsvvJUOVOqDTtKAHts4k8tboa+O3AmIT+X4QNwnSnpWCbTp0HyYx1VeRaH1jUMsveZ5CdJpTU6VB9X1AB8z+RDw9aHO2spdpnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810720; c=relaxed/simple;
	bh=6l8JZsAR+iMM8Ctsv7pi3j7qJeBN5dLs+LHJUKfuXaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XvDrK0WwGtBbyYhmZDAUNSFlXmMR/vSIUv9wpFNagjHqIbujOCr8XAgK4oxvDaDWt65LJlrUUAFbtxZypMdn5ztL4c03IhLlMQx4NtAbzecZOyWMhYC0zZZvL1iJXQO0GQmO23BDVH/XLm57d+WEJSPM7BkkU/J0oSXjsvcnjes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ihIdfvUk; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ihIdfvUk"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d73066880eso10461825ad.3
        for <linux-hardening@vger.kernel.org>; Thu, 01 Feb 2024 10:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706810718; x=1707415518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mE3jVQhJ2LuQ3qyqaFoSe5QA+s0kLrjmgP5knra8bV8=;
        b=ihIdfvUkT/HXuoS2Z4aTIEzTtWi6sxrmDNaSTtWZrK8yARsLzs50tk9HQzP+JPRynW
         1Hl+iLZ3Ypv0oQpeUeFf9QvM4pPKkyOJxvlz2BDog1bOGICdFYBaABZkLzTAy210U7d+
         ErXwagLJ0KosY+DKAikqvlVcGc05FMu3CBJOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706810718; x=1707415518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mE3jVQhJ2LuQ3qyqaFoSe5QA+s0kLrjmgP5knra8bV8=;
        b=g6qd/hkuGCB4WTHNBI3IjQZgb3OlW8EwxJwPJjSxQ1MRQVvpmyps7+3yN37wVBAJPs
         j5Lp6EcxJVXQqm0RwIp+TLzIrbVPjaCPWjUDYKwG6LGLTqPUwmyk/jt0wuW361v2fCH0
         uDyf0CWlPDhgrG3yNxWA9QvQsMrRNu80hCN1uNY++VLXDQaAoIne9QP49qSZraONGQUj
         r6dXDnH5qKE+2AvUr73gcikl5ko0sQYmbsI65YK6Z73aVZWd0mQng9UiNm4xR1bgaoQn
         oyMR7/FVEVRuLsWblt2TKw2TrrikZdAGa8oljVj104V0poivoVvW3RqTXn8ZvXeuzvY1
         qX5w==
X-Gm-Message-State: AOJu0YzdesxbR5ZCzoW4TeOFlSGgk3X0Cdc85VS4Wi/OMwjPGITOC5n0
	9ygvzNd4obQGC6mxZdOADvxE9WtoMwPqH14uEo36gEnjy64nbX8FdIa6mj/Sww==
X-Google-Smtp-Source: AGHT+IEnKFAw65wQSfXWyvw7YkwGGmk/LAfn/8Tkmy/HScFBCFeyfp0vmo18O91sli0amPnxNes3eQ==
X-Received: by 2002:a17:903:606:b0:1d9:34f8:ab94 with SMTP id kg6-20020a170903060600b001d934f8ab94mr4268050plb.60.1706810718072;
        Thu, 01 Feb 2024 10:05:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW2dH89mngLTyNFzU2DuZunjfVaZuYL3r1tIjno9+kqNseg9ctg7YNn24N5q40zOGrmo9zQRJz7mWEKN9N67F7ftXP8w0NGuPmVnPjsL0TeCfzsoSNaP2Wq1LGzsm5xDb4Vlmdo/iD/3A0GXn1vAB/vvItqL0Tf93mV5FV6EFhgsPEOb6N6ZXmynrZlDvEqZaQWkPca08aPmjL5oe1PoJ1quqQ4Iqy+QL3XTTUlcDiYqvloZkSz16Y/iFooR/+cC5UwKkwUF67seCR8fUAXGvgcxo5b7v1KbstqdqPK6CKmC/GBL2YGpycjJo7HybEHFTKK10FWgyTQwPwe70+YsJ2vhUwEexR1C9HG
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g10-20020a170902c98a00b001d8d56a8b9fsm115624plc.105.2024.02.01.10.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 10:05:17 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: gregkh@linuxfoundation.org,
	Jingzi Meng <mengjingzi@iie.ac.cn>
Cc: Kees Cook <keescook@chromium.org>,
	gpiccoli@igalia.com,
	john.ogness@linutronix.de,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pmladek@suse.com,
	rostedt@goodmis.org,
	senozhatsky@chromium.org,
	tony.luck@intel.com
Subject: Re: [PATCH] cap_syslog: remove CAP_SYS_ADMIN when dmesg_restrict
Date: Thu,  1 Feb 2024 10:05:15 -0800
Message-Id: <170681071324.3763781.3300487641248807302.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105062007.26965-1-mengjingzi@iie.ac.cn>
References: <2024010306-tweezers-skinhead-083e@gregkh> <20240105062007.26965-1-mengjingzi@iie.ac.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 05 Jan 2024 14:20:07 +0800, Jingzi Meng wrote:
> CAP_SYSLOG was separated from CAP_SYS_ADMIN and introduced in Linux
> 2.6.37 (2010-11). For a long time, certain syslog actions required
> CAP_SYS_ADMIN or CAP_SYSLOG. Maybe it’s time to officially remove
> CAP_SYS_ADMIN for more fine-grained control.
> 
> CAP_SYS_ADMIN was once removed but added back for backwards
> compatibility reasons. In commit 38ef4c2e437d ("syslog: check cap_syslog
> when dmesg_restrict") (2010-12), CAP_SYS_ADMIN was no longer needed. And
> in commit ee24aebffb75 ("cap_syslog: accept CAP_SYS_ADMIN for now")
> (2011-02), it was accepted again. Since then, CAP_SYS_ADMIN has been
> preserved.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] cap_syslog: remove CAP_SYS_ADMIN when dmesg_restrict
      https://git.kernel.org/kees/c/09ce61e27db8

Take care,

-- 
Kees Cook

