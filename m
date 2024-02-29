Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEA744368
	for <linux-hardening@vger.kernel.org>; Thu, 29 Feb 2024 23:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709249950; cv=none; b=Yhke7QIHNXyriWAAxcRg80uXeLL/x5aspr1j6dxrdvMrOLvO5hRTZXGySk/rTeMt2459Le1aFv9JCAxDunLaEYzait6pHyzAiZvzoHhyse916JKlB6QZxxU8xInxemJGTF3Ppmzh8Bh6h2eGpll6BDrOptsi0VcHoj0Q6xTpAzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709249950; c=relaxed/simple;
	bh=e/8V7q0T5PQHD8Yc+VQwsb6DOiBHkVWPVrFu2N9+wis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PszSlmsm9QYKDw4pAPuWjmxJw3NXBkrLwGmSXle25m2HGfM199mp90YnAJ3I4XnUkFFevmlq/pNgzgZ3cwAKbBsN4A3Iclep+Qwr0Ghtla9+4077P7r3B+JUkZKCZ+ZC66i2Gt+GgYGx73whxNocg6exFUiSYpB121CFKk+Dqug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AW67M3HE; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AW67M3HE"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e581ba25e1so1212954b3a.1
        for <linux-hardening@vger.kernel.org>; Thu, 29 Feb 2024 15:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709249948; x=1709854748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zrpA1mv8JfPN81Pqls2RUoWHBrGbGLLk6Rp+CKKaj/s=;
        b=AW67M3HEZ8+Ko+S4R3j/DvmN4MVoDg3TDZNuAbZqUz/VFKHMsUsdNh/+1ZdSQsSkvr
         hp9HCzh5UdgCOcyGFxcJuA9Dh9znea32nlkv4PM06/9wRhCQHGNngGYa1JAmewCY7SDl
         LcZuHZk2REpIz+uTgCvUUL3ru3b3OYswWiuXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709249948; x=1709854748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrpA1mv8JfPN81Pqls2RUoWHBrGbGLLk6Rp+CKKaj/s=;
        b=OHgLTIjGD2t8qHdQ/Hi+qs92Tce1gNtVDUB83hBDl9MF20kvq7Ht9eZ+vx4v0licqb
         rlhfxw1Pi31XQ3wNHvLi9OCAY/RYJ9Zi3ElEM20xlrfJ7azSMjWntuls4n5Bj2UBsD99
         lRP42gwC7HYeiFHKNHLUD0A2vv6INrFf3Z5sCh9uc8q/lWqUiRZdiNNnQElAzfDXOJ06
         AAg9Gy9GwNw3/uPjJ1xJ0AFbxqi8zNT4rizp/HwREm3mPckW0z7vgP39PO+of8HmFP4J
         CvB6VygMNVL/ETCzSVjVMuC0cY/JezzbxUd+kk56NOOJo7U2R1kxj3higy3SIUpEBwCJ
         zdPQ==
X-Gm-Message-State: AOJu0YzNzji8EYNSaCCBbmWSg60PhPZTRpzK7uH5gCSuvUMQMotFxABG
	o4+i199862udlRxtqtGLn1eXXbfYSVWr0GlOcwz4OeJxTmU6CqrtRSuk4qChEEmsbMHahyYmiy0
	=
X-Google-Smtp-Source: AGHT+IGJVW2Kg8FOzevwO891TfCYJpBIFcznOfoM7q4NgpLUnUQXz9LiC/9jjgPSzgqu4jXznWV/FQ==
X-Received: by 2002:a05:6a00:2293:b0:6e5:599a:5252 with SMTP id f19-20020a056a00229300b006e5599a5252mr665091pfe.15.1709249947822;
        Thu, 29 Feb 2024 15:39:07 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m19-20020aa78a13000000b006e509762bc2sm1813393pfa.26.2024.02.29.15.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 15:39:07 -0800 (PST)
Date: Thu, 29 Feb 2024 15:39:06 -0800
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] string: Convert helpers selftest to KUnit
Message-ID: <202402291539.F0E3E63061@keescook>
References: <20240229233432.work.675-kees@kernel.org>
 <20240229233528.1538803-2-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229233528.1538803-2-keescook@chromium.org>

On Thu, Feb 29, 2024 at 03:35:24PM -0800, Kees Cook wrote:
> Convert test-string_helpers.c to KUnit so it can be easily run with
> everything else.

Gah, I will send a v2. I thought I was doing this on top of the
get_size() change, but I didn't...

-- 
Kees Cook
