Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEC9C04A94
	for <linux-hardening@archiver.kernel.org>; Thu, 27 Jul 2023 15:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbjG0PxE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 27 Jul 2023 11:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbjG0PxC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 27 Jul 2023 11:53:02 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53F32723
        for <linux-hardening@vger.kernel.org>; Thu, 27 Jul 2023 08:53:01 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bbbbb77b38so6411635ad.3
        for <linux-hardening@vger.kernel.org>; Thu, 27 Jul 2023 08:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690473181; x=1691077981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKtgqp1u2xh8Lnzw63ydJQR4zWouaxM7EYEQJ/Gqtx8=;
        b=Ys0TU5LF97kp5pUBJu1vJUOHVdfiuMEiEWvnozXPP8CbclNLX8ADuMxnV7t5C4K1yK
         D8Joi0BZrq76t8TP/CbbK4zREwfVSJBylrOQgzGv+ocsE7bBRfar+iy02IEupLjZ6qDn
         Ui7F4LgDa5xzdF161819L7flP4kCFpn5B53KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690473181; x=1691077981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKtgqp1u2xh8Lnzw63ydJQR4zWouaxM7EYEQJ/Gqtx8=;
        b=O+QkMUbt41efZh7A3z+Ja9OfLwI1hrnccYDc1aR9RGOJjDNT8OR0apUiqL7/FVHMjG
         iG2w0MVOQh+81ZMGAsxkpj8I1j+rbQLUJzUb/l7rxsJmMQTkqdnw+IY5WKBpvvL17Ywa
         Bo8CxkE2JOuOSQzI5jW3gz/MM6y7MqIRQ3TJHsfaLlrIbo6GfNgxzEPrH/akAVH27x9W
         0hpFYLZ2OjlfYZtRKcvvxJs9UaFB6S4cjCVVUErx8wQTuK0QVNeJjCDjnNoGWnxZmPrr
         aWGrDt3SUBXRR3uq6HzDG3CBFD4i+6b6ed6+fm5YzBibcFlvdU03OFsobM+TU1OUIMdY
         ZW/w==
X-Gm-Message-State: ABy/qLbQPJpR97BgqU7masrfku+gvphonkjsK/00i8BBxbr26kbMn7wm
        FBHek1SDiP8vcw90C3i9WHR1D8gbZRNdr6zJdmo=
X-Google-Smtp-Source: APBJJlHQu3CTwASavzZKIq52nhmrqYf20V0hkWuKka0SpYId/y4TdpNecTBvy3SyWaDDMBHHR3OOLQ==
X-Received: by 2002:a17:902:f545:b0:1bb:a367:a70 with SMTP id h5-20020a170902f54500b001bba3670a70mr4328734plf.17.1690473181183;
        Thu, 27 Jul 2023 08:53:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e21-20020a170902d39500b001b8959fb293sm1820901pld.125.2023.07.27.08.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 08:52:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Haowen Bai <baihaowen@meizu.com>
Subject: Re: [PATCH] um: Remove strlcpy declaration
Date:   Thu, 27 Jul 2023 08:52:54 -0700
Message-Id: <169047317154.2400214.3532264877542326061.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230703160641.1790935-1-azeemshaikh38@gmail.com>
References: <20230703160641.1790935-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


On Mon, 03 Jul 2023 16:06:41 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Applied, thanks!

[1/1] um: Remove strlcpy declaration
      https://git.kernel.org/kees/c/61ce78f29a69

Best regards,
-- 
Kees Cook

