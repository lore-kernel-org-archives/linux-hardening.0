Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8E91C6AD
	for <linux-hardening@vger.kernel.org>; Wed,  8 Nov 2023 23:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FEPZw8Jh"
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4172688
	for <linux-hardening@vger.kernel.org>; Wed,  8 Nov 2023 15:55:05 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6b7f0170d7bso242277b3a.2
        for <linux-hardening@vger.kernel.org>; Wed, 08 Nov 2023 15:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699487705; x=1700092505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9Zj6aiYPItnuW/II6rnVjTEgzD4cCUTmx7jt9HMfXA=;
        b=FEPZw8Jhw5EDWq1LtOTYiwL3+l/Fc/leSau8qVX6MxAosWhTLSU9XomEN8k0gGJrkD
         bd5OpBXKfBQQdxV33FNnzfj9xOL2WXUvA8dZllvRWjoB2HpK3ZYwrM7rQ59Jr0RoPYva
         sM8FOyP6O8HGditWkZX9RCrZCIiZfCt67yFqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699487705; x=1700092505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9Zj6aiYPItnuW/II6rnVjTEgzD4cCUTmx7jt9HMfXA=;
        b=shDQZU0CfvW6ctYPZ8FpdcQYL4YsipmGNnV/eXB24dmaW02/YZWJjclVTDf1/6KcJt
         4syFg7VYc+JrXyKc6loFjJjbUUvw6V3gG6MPrGquXSDz9qOWVuK4k3QH8nYdZ4sdLLNM
         wyBU12cg/4s3kb9+xmbKm3oy8oF2kOsm6BJUH9qcT+u2T+Z/5nJ269Xgy2drKRvVkSAw
         dLzFDb8aPIpqkez07U3u/B2ZiCeHsqMYShblzG4FFnLsy3UH2junKmtEqn8qlP7zr7KI
         Xac+6BHZiIqwmom1LpUmnKBfHCqFDyf5xXIWbRqBKPncjd9ci69F3Qw5MDC0kOtNC4Oc
         XOXA==
X-Gm-Message-State: AOJu0YzoKkV9lYcZuU2aO035aHNzXcxpCffD8MteyCePSYNXr0kQ6bZ+
	ghu8XIxGI8hmJfCtnzPBS16jjg==
X-Google-Smtp-Source: AGHT+IG/qaDCcej89YQMoQMv/HF3e5O7ROLDD78dWthl3PM34DsDAfNZV3iFa4+MyubwH0R/Ie9e3Q==
X-Received: by 2002:a05:6a00:1397:b0:6be:1f19:e604 with SMTP id t23-20020a056a00139700b006be1f19e604mr3874872pfg.21.1699487705464;
        Wed, 08 Nov 2023 15:55:05 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j6-20020a056a00234600b0068ffd56f705sm9413130pfj.118.2023.11.08.15.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 15:55:04 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Konstantin Runov <runebone1@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixed typo (args -> argc) in plugin description
Date: Wed,  8 Nov 2023 15:54:59 -0800
Message-Id: <169948769743.634942.16140786169339944905.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030094508.245432-1-runebone1@gmail.com>
References: <20231030094508.245432-1-runebone1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 30 Oct 2023 12:45:08 +0300, Konstantin Runov wrote:
> Clearly, argc should be used
> 
> 

Applied to for-next/hardening, thanks!

[1/1] Fixed typo (args -> argc) in plugin description
      https://git.kernel.org/kees/c/b98cf399839e

Take care,

-- 
Kees Cook

