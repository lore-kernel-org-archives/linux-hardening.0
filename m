Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796BAD308
	for <linux-hardening@vger.kernel.org>; Fri,  2 Feb 2024 03:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706844595; cv=none; b=YE4lTtmqGunaAASVuohq+HLEepWqNgZ7P5YSVcmdAg8RWVbbtqc9ENJrtQoc2Vb+JTDuuXAxvaUPF1Y9oWMlbya4EXgziupWxstHMQoSbCfFe/ME7xAJCa+lFuRgS4NSUI9EP2XnnX/G7f7txK/MEz7Hs7xpKG7oG1mJaxIm2X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706844595; c=relaxed/simple;
	bh=FQPEDa1ZpskrfIY7Nl1IZ8DX+tkOt+NBh/6iZYeP0oM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cgSEE5ejVgZ9ci6QxGzaU+y5lH8VM2/77O3R1WqI3VrcaQx+QG9+ywVAJ9fJoXi6nIMH+pSSZIXFX82vUlf3NU3xW3M8KlYDa6D52V5YvQGN9WP9hR+65X/5ihgA/ThFmMAJMCdbdAAzrZAqQ40IdIfUPj9aYnYJRsVh+MnzPR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GYF6HEZy; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GYF6HEZy"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5111f40b8beso2000134e87.2
        for <linux-hardening@vger.kernel.org>; Thu, 01 Feb 2024 19:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706844591; x=1707449391; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qJx1hqlSbD14E0hZKRTCOkIDna5e/202U5M9wYP7Mg8=;
        b=GYF6HEZyywWHVD/NrHcSgXe2eP7YL3/Mk+MWgzmCPxb+uJqvcLmwXWazeguLwP64zX
         LxCYJxcENb+nVIZLU/3WlzkLJD7wNpp1NM3YMCpa0itovzhmt38yTvCp1ODkJzaX1qWL
         yaiJDf5UZxhPvB0E7xLcG649oG49FrLlKJtms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706844591; x=1707449391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJx1hqlSbD14E0hZKRTCOkIDna5e/202U5M9wYP7Mg8=;
        b=pkzm/Oh+ax+PTdEQYIEGTSd5GsH7n7WFIRFyuinLSNfJnlZxVg6VL6Tlc5/qQpERA0
         AEop0OqtqEir16RadAcoKDxBXV6YHHQevUh5p3DpT8zyaqw+/RaqiXRlGWqu29bu0NBO
         naF3ZwQ44jNxrX83cZRqwBPWtk+ArJanJ/kVvPSrpItFBmcSnLnknZ3zkBct4qjHCfsc
         ucxynXUofm6fU4ARZ6dI7zvZpEphOQHQcrWKJr7V9S/P04wrVTZ0n/2Wxj3/Ts1eZ+8Q
         c+m57IFnu6PHt5YWvob5lMU34x4clTKKQY/kIHw3q0ob1hOqH3rZrhFmbhFibetnf/ol
         hmqA==
X-Gm-Message-State: AOJu0YzDjC3/w/FtFG9k7l6kLRItv/rvLwgK+jjH98tbR2kSCFgfpTTH
	te6T4n/wnTAb2pBIPstGAz0SOesJILix3By4kG+buxJGgNqqVA5NACAJ7oZ9VggWjTpl9dGThfu
	C27nAeQ==
X-Google-Smtp-Source: AGHT+IE6+Wd5YxDsW3p0I6MwIegsebuiekkkH2/ABvfP9BI5dwv+ygsQfv00hHPvVRZwgLKtVXCWKA==
X-Received: by 2002:a05:6512:2f3:b0:50e:7124:8953 with SMTP id m19-20020a05651202f300b0050e71248953mr2410241lfq.26.1706844591468;
        Thu, 01 Feb 2024 19:29:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX8XHTQnTLaPsUhsDyI30bV7eoK7eHULfFStVlfzy6kXEX/tYBTFjvl4xKdDUFGKvMh9MYOasxYR4amEKDqXOaBO/gSfw8kh7oiiSTZ1jKM
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id i27-20020a198c5b000000b005102265f5cdsm155634lfj.159.2024.02.01.19.29.51
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 19:29:51 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5113186bd61so1817268e87.0
        for <linux-hardening@vger.kernel.org>; Thu, 01 Feb 2024 19:29:51 -0800 (PST)
X-Received: by 2002:a05:651c:1249:b0:2d0:87ea:a132 with SMTP id
 h9-20020a05651c124900b002d087eaa132mr159099ljh.27.1706844590714; Thu, 01 Feb
 2024 19:29:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131193411.opisg5yoyxkwoyil@revolver>
 <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
 <20240201204512.ht3e33yj77kkxi4q@revolver> <60731.1706826280@cvs.openbsd.org>
 <2024020137-hacking-tightwad-a485@gregkh> <CABi2SkVb1goM95FT5v2K18NHbaLitLpK6fL+wE6Y47z8yvW0Nw@mail.gmail.com>
In-Reply-To: <CABi2SkVb1goM95FT5v2K18NHbaLitLpK6fL+wE6Y47z8yvW0Nw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 1 Feb 2024 19:29:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjGGgfAoiEdPqLdib7VvQgG7uVXpTPzJ9jTW0HesRpPwQ@mail.gmail.com>
Message-ID: <CAHk-=wjGGgfAoiEdPqLdib7VvQgG7uVXpTPzJ9jTW0HesRpPwQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Introduce mseal
To: Jeff Xu <jeffxu@chromium.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, willy@infradead.org, 
	usama.anjum@collabora.com, rdunlap@infradead.org, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 19:24, Jeff Xu <jeffxu@chromium.org> wrote:
>
> The patch Stephan developed was based on V1 of the patch, IIRC, which
> is really ancient, and it is not based on MAP_SEALABLE, which is a
> more recent development entirely from me.

So the problem with this whole patch series from the very beginning
was that it was very specialized, and COMPLETELY OVER-ENGINEERED.

It got simpler at one point. And then you started adding these
features that have absolutely no reason for them. Again.

It's frustrating. And it's not making it more likely to be ever merged.

               Linus
