Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alarsen.net header.i=@alarsen.net header.b="J/krViSp"
Received: from mail.alarsen.net (mail.alarsen.net [144.76.18.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF215182;
	Wed, 13 Dec 2023 08:43:11 -0800 (PST)
Received: from oscar.alarsen.net (unknown [IPv6:fd8b:531:bccf:96:1d3c:7bb8:afc9:c861])
	by joe.alarsen.net (Postfix) with ESMTPS id 3F50118053D;
	Wed, 13 Dec 2023 17:43:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alarsen.net; s=joe;
	t=1702485789; bh=R+zOwHXfxGLUiGFVYN3h/JK/ygMXJQiQ4IPI6Z/ElbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J/krViSp5LGEjsvcsVeI7/JtvIMP9EyvgAZT8TqCRVzlCoGZOYj7griiHetYo8X6s
	 SfKcfFH2D2tyI8iBkp4WldadooHOuLfCFhywNYLv5f3FByNcy5zbrRe/G12500cz17
	 yYIHT1qdEos3JgqVgHPS47E+jyD0O8rwd3OWeKc4=
Received: from oscar.localnet (localhost [IPv6:::1])
	by oscar.alarsen.net (Postfix) with ESMTPS id 16F21A7E;
	Wed, 13 Dec 2023 17:43:09 +0100 (CET)
From: Anders Larsen <al@alarsen.net>
To: Kees Cook <keescook@chromium.org>, Ronald Monthero <debug.penguin32@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/2] qnx4: Avoid confusing compiler about buffer lengths
Date: Wed, 13 Dec 2023 17:43:08 +0100
Message-ID: <12341921.O9o76ZdvQC@oscar>
In-Reply-To: <170241597608.164694.1762861756800879766.b4-ty@chromium.org>
References: <20231130205010.it.412-kees@kernel.org> <170241597608.164694.1762861756800879766.b4-ty@chromium.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Kees,

On 2023-12-12 22:19 Kees Cook wrote:
> On Thu, 30 Nov 2023 12:51:17 -0800, Kees Cook wrote:
> > This attempts to fix the issue Ronald Monthero found[1]. Avoids using a
> > too-short struct buffer when reading the string, by using the existing
> > struct union.
> > 
> > -Kees
> > 
> > [1]
> > https://lore.kernel.org/lkml/20231112095353.579855-1-debug.penguin32@gmai
> > l.com/
> > 
> > [...]
> 
> I'll put these in -next since there's been no more discussion on it.
> 
> Applied to for-next/hardening, thanks!

thanks for taking care of this (and apologies for me being unresponsive)

If it's not too late, feel free to add
Acked-by: Anders Larsen <al@alarsen.net>

Cheers
Anders


