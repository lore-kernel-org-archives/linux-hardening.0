Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6FD37C
	for <linux-hardening@vger.kernel.org>; Sat, 21 Oct 2023 00:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="j2jRoGlL"
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB45D7E;
	Fri, 20 Oct 2023 17:53:15 -0700 (PDT)
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 64E616607337;
	Sat, 21 Oct 2023 01:53:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1697849594;
	bh=YoZOTGL/RGBwXV8TmpGCsyQF9OtErh2EOHQgUYwMmLA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=j2jRoGlLqCWCVt1rry/ZH+gUKllDXDsx4+RP/tV0dQlNbfra2TiXpHX9vYutbq4za
	 1+3PSnOyrUSjaJXhFezPy0T/f9OVnSA7xw0r4ASgfPJLqp3kzf1tMj5LZ32T5q5p1Y
	 Ij1idS0XEqfsv3ivHsWNuNdDjmZadtFM8/kypcCZaeEGTeMSN7+/Y8jW934vwBKxDI
	 tmj3N6JSmVaJtLqdrYN6TsFfn3M8SDk2pwQZQeBe7DZbpqCwxJDHPp2XdUGWAjwQ+Y
	 A0aFfEONU9IHkMhjtTnXkNMdXpbalzNp/0rhRgXdiw6uB9bZzIJQ7ZvsWWk0yjkkj+
	 0A4BzarBoLKkg==
Received: by mercury (Postfix, from userid 1000)
	id 3323D1066140; Sat, 21 Oct 2023 02:53:11 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Justin Stitt <justinstitt@google.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20231020-strncpy-drivers-power-supply-bq256xx_charger-c-v1-1-2fad856124f9@google.com>
References: <20231020-strncpy-drivers-power-supply-bq256xx_charger-c-v1-1-2fad856124f9@google.com>
Subject: Re: [PATCH] power: supply: bq256xx: replace deprecated strncpy
 with strscpy
Message-Id: <169784959119.1512524.17254965326687207581.b4-ty@collabora.com>
Date: Sat, 21 Oct 2023 02:53:11 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Fri, 20 Oct 2023 19:05:25 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect bq->model_name to be NUL-terminated based on its usage with
> sysfs_emit and format strings:
> 
> [...]

Applied, thanks!

[1/1] power: supply: bq256xx: replace deprecated strncpy with strscpy
      commit: 056a75599f5e676d497bbf9b29157877f542e56b

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

