Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9EE5F861
	for <linux-hardening@vger.kernel.org>; Mon, 18 Mar 2024 23:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710805906; cv=none; b=kdoy/bEJ/uoa4NJNttE8C1rvINBOiyqjIFP+c68kkjAckWHYoIVfmAjARe9Ti7KF3iQx68IU7WObGpEGO3Nz0TEHl7YizHL6syCl0cmhYGMw85bIco7KtuwLkj6C3HDbkyC2FwfguiFkbQZLVFIOdQ8FzcLQiLkmz5Ri5s5Ixk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710805906; c=relaxed/simple;
	bh=dsiON50OCpUxEqQfubPrK6S1drnpo7LDAB6I6guhQwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rA12/0DiHyvv+cn90TI3pZ4sjs3MvJNcudDdl+hjb87LOoGSWkxT88uPpNmnI5yBajSopNhmGeoXgOr6eXxgBVGgk4DEFT5qTIWQhg7noLVyF/5yHV2sHuyxJHB2moXYHTPiPHZUVuB88eyCntve88CpiqHv/wqvjLd8bkACMK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P8WsICKV; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P8WsICKV"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e6b729669bso4527600b3a.3
        for <linux-hardening@vger.kernel.org>; Mon, 18 Mar 2024 16:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710805904; x=1711410704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hLMhotFwHtUIj1BzQPggj9DUeFsCq1j3jcfIf9VTyoc=;
        b=P8WsICKVxlSAz4F8g7dk9sqPnWkmoeUQaGxaE/RcXsq46+RzXY4eNgafJ+Q7Wv2T/g
         6iZpsH1bGFjVIQnNJM9wuGrxUmVgg4bCv9aIjy8IVDzC8auTa6jhnhi9pZkAmXJepLMC
         P2swYLpcOhmmE6QUD8b69i48EwBksI6lhE9C0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710805904; x=1711410704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLMhotFwHtUIj1BzQPggj9DUeFsCq1j3jcfIf9VTyoc=;
        b=DZXalal7ujnbksBOC0G/tS2S+rS8GWZZw5WW5ZFdSu3Tv9uTw1kgIof9Y1fYDgcmhr
         /CpINEcEm0taE743DX0gKTaKj6euh/CTsdNVUV4payRZtwM1UYmTuckQRZJhpoqEsj5q
         yp6t43Tov6QDncE+M9Mh8apArQaGfI9T8UTFOfir9Wt67pR68Jp4hRgW19d8mB/Mq1Q8
         nA9+GTKQvAwDJAjqt4OObBqtI8lthaYVC1FozIoMrAaEPJcRSCIRqhCEaJmyzg0mySE+
         NbBO/IkOzOpd8JSW01MkA/Iaw8UKC9Lknaz1VJiBqrnaLak72SKr1xGEXi+vzjDFCUJU
         Se3g==
X-Forwarded-Encrypted: i=1; AJvYcCVbzNssYMWDxKYN+HAwNjr/gHXrm10f26tgxCFtq+chdBRf5EVHhIkkFFiPEOYot7kw1tW5sLnwzdljo57NgwSJ6lJrS8VSl3/VgAeABAaH
X-Gm-Message-State: AOJu0YzyQWv0Bi3h8Ta94a3KLyngVg3aIs/8bJNC7yuDJawQRosxjWYn
	GX8I5h7xy2Lp3Q+haDNZ6Vh/vbKBufcOlwsHhj9Bq5lkCwJoXS1s0OnDki1HVw==
X-Google-Smtp-Source: AGHT+IGhmI3OnxSJK1d1n+L262uVpD36CKvUImRbH1cN5KzZCm4C/jl9bprotTYRkRFReOGVa3dn4A==
X-Received: by 2002:a05:6a00:a23:b0:6e6:7abd:b870 with SMTP id p35-20020a056a000a2300b006e67abdb870mr1687932pfh.12.1710805904517;
        Mon, 18 Mar 2024 16:51:44 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ks25-20020a056a004b9900b006e6f2251898sm7190594pfb.0.2024.03.18.16.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 16:51:43 -0700 (PDT)
Date: Mon, 18 Mar 2024 16:51:43 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] soc: qcom: cmd-db: replace deprecated strncpy with
 strtomem
Message-ID: <202403181651.8F755705A@keescook>
References: <20240318-strncpy-drivers-soc-qcom-cmd-db-c-v2-1-8f6ebf1bd891@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318-strncpy-drivers-soc-qcom-cmd-db-c-v2-1-8f6ebf1bd891@google.com>

On Mon, Mar 18, 2024 at 10:49:23PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> @query is already marked as __nonstring and doesn't need to be
> NUL-terminated. Since @id is a string, we can use the self-describing
> string API strtomem().
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Nice! A textbook use for strtomem(). :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
