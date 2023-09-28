Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0E33AC3D
	for <linux-hardening@vger.kernel.org>; Thu, 28 Sep 2023 13:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA69FC433C8;
	Thu, 28 Sep 2023 13:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695908491;
	bh=rJxLo1ABDRJDSxy1BujIrMAZQ/znSO0a+HwmrquB1+U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mav+ZW23Dj6p8y5GSitPt1RgAPgFnreDpKvaTT6jmn2sRET+o9tGZOq2vct+4wJ6p
	 MCV8h6xcv3Y5m81H44uouJ6banZb+ZuA0Fl/yCI7xzrOSbD+kSjc3ZK0C4tE9KiDhF
	 2SeONbWxfHiJwFLNbBj+jY9iCz+eIAT8Vxa7VD90pT997dMhU8rgpjFO7/wJx6nycQ
	 OrqX2d9nItKFqSD4BRx1sKWnSRZjyd4NsX52kcB+6N0yyAXSlmmIaOe6xs5m4llaXl
	 o8TjNhUw1SxgRvIvrv6NkpaG2Kq+rlIdBN8CRzEMzGeyc1F8usoGT0oIpB72QnFybG
	 pIrof6A38DGHw==
From: Lee Jones <lee@kernel.org>
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Justin Stitt <justinstitt@google.com>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20230922-strncpy-drivers-leds-leds-lp3952-c-v1-1-4941d6f60ca4@google.com>
References: <20230922-strncpy-drivers-leds-leds-lp3952-c-v1-1-4941d6f60ca4@google.com>
Subject: Re: (subset) [PATCH] leds: lp3952: replace deprecated strncpy with
 strscpy
Message-Id: <169590849042.1603670.14283146758350554856.b4-ty@kernel.org>
Date: Thu, 28 Sep 2023 14:41:30 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2

On Fri, 22 Sep 2023 15:27:17 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect `dest` to be NUL-terminated due to its use with dev_err.
> 
> lp3952_get_label()'s  dest argument is priv->leds[i].name:
> |    acpi_ret = lp3952_get_label(&priv->client->dev, led_name_hdl[i],
> |                                priv->leds[i].name);
> ... which is then assigned to:
> |    priv->leds[i].cdev.name = priv->leds[i].name;
> ... which is used with a format string
> |    dev_err(&priv->client->dev,
> |            "couldn't register LED %s\n",
> |            priv->leds[i].cdev.name);
> 
> [...]

Applied, thanks!

[1/1] leds: lp3952: replace deprecated strncpy with strscpy
      commit: 821d3ff4b4e2c689576a623348555114e3f2f1c2

--
Lee Jones [李琼斯]

