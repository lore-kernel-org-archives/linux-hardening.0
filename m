Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E021E14E2EC
	for <linux-hardening@vger.kernel.org>; Thu, 22 Feb 2024 15:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617178; cv=none; b=Cpzpw0ioULioX6eTYFS4uw4wf/23VG9Cy9ntHcH66t1c95y7Lfn5KhAeVIw8HSkpWlxlYUVE5/VyE19u/ulDCFTc9Ez+CDHhOKRrG7ZLFqwXr9hHLNfgViNgZk3EqyQWu7FOtu3jpAk8m5nLDBBz26C3Eb7PUPacuPOXn70Ps0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617178; c=relaxed/simple;
	bh=Vd3UzDgmX7Ao1DnE+nzyieBLFnftQ/B8sJIJRrxRpco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ux/uMIoa/Bw3r10heIJV/f48T/XSu3siX/WEZxirgd4D+pe3wYP+eOg24JIiN8rqrV4rdDg37TVgTEDyVShN+1yWimr5u2++teYfEIwNdiwI5um8F7+CwIXi3CHm41eMu/Ga7X1vabsZI2xJ99g3Jy3QNp/IN6BLqBJnpoUuscc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bSXkMABR; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bSXkMABR"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e47a104c2eso2177945b3a.2
        for <linux-hardening@vger.kernel.org>; Thu, 22 Feb 2024 07:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708617176; x=1709221976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1gfwnWmu63cYswR0b/u7RtSKFeQyr0VL4Kut1suu2n8=;
        b=bSXkMABRd5Gy9iYQZn6+kg10M0jGKVqcKbqT6VPDcuAA7I4OwHLOV8WaS+y/iZyRAA
         ZXkOoGHpESpLUfIhI9+kzg2G+h3GF+ylw44PN5ekhfb4B0mYFV+jnIr21/MZ8Ub7Wnw1
         xJO9AxAD0f5W355FyYMKjxJ+6Hq2yKqAYPkWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708617176; x=1709221976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gfwnWmu63cYswR0b/u7RtSKFeQyr0VL4Kut1suu2n8=;
        b=qDrqvB5HpuHEaweUKVg4FHWyyoKRq+QLgpdDsMlbsKWT+7iGtMrA/4Gyg9MripMmRe
         7hh2ZVomCk4Ic6edVCI5xo+ef3Y1qhDuGW/Lmgkvkqg0WwR3J4caYFaxzqeFYvP0wFql
         BHhTgSfaJOgN5KLItHNv7amMDg5VY6XxNI2KV3W4N79wG6PDYHBTg0SjASMyiciYtgIN
         XtqmLDqXMHoY7rySaJ8CVk9piwaQ5C1dJENIZ/Jwm46HRfFdt3VkUqPh3M2zEViNNQtI
         0N15pihO5MZAOhMKgNO/PYeyMoTB2qheG88P+TTJyxu3dTYed6p+uCK/p1+vSKGgQDAS
         Hlig==
X-Forwarded-Encrypted: i=1; AJvYcCWOjtopWl3ISYr1A+KN+Umql2ZAMB/luKhwZR39P1s5h2K/I6Plo9s7DoZj/vOY5ZHR/92T48kjegO40foj8gpfSPY2ad2/GRH1ljtH2ual
X-Gm-Message-State: AOJu0Yx5dPDdS7492XvrtVV1EKGk51CWt5CyhK2kogGXFT2JmSQn7v06
	0E/eLS1RuUcaucVRvhmVMEG5j7xEOlE+VwDhrqXeQ17tBXvMaCbLad7hLg5FlA==
X-Google-Smtp-Source: AGHT+IGrtsHGeHfg7xJD4IpKzMvkDmfLWoRjY3MrY0wjNmBdDYmkUNv35SM8aT2MKwO5Lko2A1nlBA==
X-Received: by 2002:aa7:90c6:0:b0:6e1:44ec:8e9e with SMTP id k6-20020aa790c6000000b006e144ec8e9emr14895496pfk.21.1708617176218;
        Thu, 22 Feb 2024 07:52:56 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g19-20020a056a0023d300b006e469e8b634sm7589863pfc.3.2024.02.22.07.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 07:52:55 -0800 (PST)
Date: Thu, 22 Feb 2024 07:52:54 -0800
From: Kees Cook <keescook@chromium.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Mark Rutland <mark.rutland@arm.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Haowen Bai <baihaowen@meizu.com>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Yonghong Song <yonghong.song@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	Yafang Shao <laoar.shao@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>,
	Anton Protopopov <aspsk@isovalent.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5] bpf: Replace bpf_lpm_trie_key 0-length array with
 flexible array
Message-ID: <202402220751.2370A263AD@keescook>
References: <20240221222613.do.428-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221222613.do.428-kees@kernel.org>

On Wed, Feb 21, 2024 at 02:26:20PM -0800, Kees Cook wrote:
> Replace deprecated 0-length array in struct bpf_lpm_trie_key with
> flexible array. Found with GCC 13:

Nope, still breaking CI. I will respin again...
https://github.com/kernel-patches/bpf/actions/runs/7996482005/job/21839056683?pr=6451

-Kees

-- 
Kees Cook
