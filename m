Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33FF71B50
	for <linux-hardening@vger.kernel.org>; Mon, 15 Apr 2024 18:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713204564; cv=none; b=oQbYfNVs82y2ewPelylyRQSglg3eGdg96FE+v3MKDbwkRBysIJrdNcmCjZPHCh+Q7Vt80QdVMyt6bdeZnqpCs19P1355pJzEjxsloaOGK0AAYt41BG14e2X1IbcshqtpDMNgfe8fjn9WcLN8feboe3fbwJxvb260z61Eu6tUzoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713204564; c=relaxed/simple;
	bh=eb7RuqxydoFas47SsFIwZX7CmFPluv80e4R8SoHBr5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/fx22DzspyczTs8NObNGCv0PUkysQZVEdrGuefzMwUeaz8y1WUuSqaxkPd4crsba/+NNxWUeMJmxI0Tp+JdQEwa7xAQK0kRjAx0nhU0NubGt9NOGshQ3REzI1AwbnFydiVsJrlHU/Bqj+Cad7gtHomxWg7vsCgwA2XMixP0FpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eZIE2D+f; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eZIE2D+f"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e504f58230so27997645ad.2
        for <linux-hardening@vger.kernel.org>; Mon, 15 Apr 2024 11:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713204563; x=1713809363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkTZc6XkL8FeYCjPFrO6bTJgIQx6kLh5TdHD7a6mqxs=;
        b=eZIE2D+f8QekrpuWay/zdAZ1k80EfFgZtMi2g5JVTs8ykKpA4OcCADFYU6yDCsW88g
         S3gkek8CnMg/uvrv8p1Voy7T+KHW4VE4BxBAXFT6JgO/x1w1oUEKS0/jNelCHhUrKVUG
         4Zco1gWOzb+PnVGE4MsHT0ogO65gvXeXtu5vQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713204563; x=1713809363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkTZc6XkL8FeYCjPFrO6bTJgIQx6kLh5TdHD7a6mqxs=;
        b=f1huygNhJTtpwB2BFDr9LCPaFDblAK5dWN1wwMFUTzkCKRksMd4QNp+ZG/2ZIB4xZe
         Vo+WOX+4PSQGM9skJMBQpOSB4RIs0rNlQObzmN2WIhtzz/EHpO1wY9owcE4qjI4vZqMr
         PDbZKlZoUNPSMXuwbOxwfy5vak7LFYZNa6iH2E/W4K1mEh9a3/h38TzEsiO8Y5rzf/wf
         MgvAz6www7ynvcuZjjKjCUn2XXXG8iVJGXokwCQuoWqAyHGZdq9e6JDqFU/a6wNcRknI
         iWzGjCQNk19tWCRl/EpPo0YDwzTiDS+17vjIEVCdjnAhZ7HNufi9/bPBuEay8kk1VjxW
         rQ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcvZjAdRcIfuLV9eDc9woAiXFGVx27HVQctkstoErLsg7gItgY9kNzYD6fJ8U7NS7TdOJOq2g3VsAe0jYOJeNTMIdaw0Shh0mgh4AKDsz/
X-Gm-Message-State: AOJu0YxVhY4pzZlcHHQyYGnue5XIQZF6Vm05li0AjRTc/0q4VoaWStqB
	FnOKLgTJw1TSDunGwjvf/Sezz3N49Imd5zQZF5tLVymbmmQw7sxw/rp2xMArgg==
X-Google-Smtp-Source: AGHT+IEe6B6Ws6berlSTBcbjruG3i3BTWWCbetQgyGWw3sCNk24j27rJc7E8j3Ld5qUo912GTxv16Q==
X-Received: by 2002:a17:902:9a4b:b0:1e5:5c8c:67ec with SMTP id x11-20020a1709029a4b00b001e55c8c67ecmr8090687plv.5.1713204562991;
        Mon, 15 Apr 2024 11:09:22 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jz5-20020a170903430500b001e41f1dda43sm8263797plb.75.2024.04.15.11.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 11:09:22 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	gustavoars@kernel.org,
	justinstitt@google.com,
	linux-hardening@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH 0/2] configs/hardening: Some fixes for UBSAN
Date: Mon, 15 Apr 2024 11:09:19 -0700
Message-Id: <171320455703.253555.575256453738819068.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411-fix-ubsan-in-hardening-config-v1-0-e0177c80ffaa@kernel.org>
References: <20240411-fix-ubsan-in-hardening-config-v1-0-e0177c80ffaa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 11 Apr 2024 11:11:05 -0700, Nathan Chancellor wrote:
> This series was spurred by a couple of recent UBSAN reports in our
> continuous integration that appear to be related to
> CONFIG_UBSAN_SIGNED_WRAP (which gets enabled with hardening.config due
> to 'default UBSAN'), as they only appear with clang-19 and newer:
> 
>   https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/8646488985/job/23709324479#step:6:500
>   https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/8646488985/job/23709330815#step:6:651
> 
> [...]

Applied to for-next/hardening, thanks!

[1/2] configs/hardening: Fix disabling UBSAN configurations
      https://git.kernel.org/kees/c/e048d668f296
[2/2] configs/hardening: Disable CONFIG_UBSAN_SIGNED_WRAP
      https://git.kernel.org/kees/c/7fcb91d94e89

Take care,

-- 
Kees Cook

