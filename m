Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A41C54EE9
	for <linux-hardening@archiver.kernel.org>; Tue, 27 Sep 2022 12:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiI0M7z (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 27 Sep 2022 08:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiI0M7y (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 27 Sep 2022 08:59:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B127F50185;
        Tue, 27 Sep 2022 05:59:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08E6F61965;
        Tue, 27 Sep 2022 12:59:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329B8C433D7;
        Tue, 27 Sep 2022 12:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664283591;
        bh=BSMIKJNSh2UY7QcBDbGnHiB8Z9/zuSk77eFA25iPrYA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=TP3jMC8TxSwQTANEvrCHalkWW8MMNfHVWAlA4oD7xkq4YoPkoLV+71w/28Rtx8Dpx
         Fss7T8HWH0rUxOgCPdhme2NqzMsW88PaXYQJnTsp5oXu+iivTLrgI9AO7bJeL6G9Te
         18zkBdNzghB9nFdj/g+UD7+YJN1Cc//ZtB1i/qSb+8U5tvAl3m6Q3JHBEozEuVCKeM
         NSbikZJVgMPyFLmKFuIJRFQwDbebT3QTTdZBtr28Rj/WSFIgqFp0CHhQ9L68UZ+3zD
         zdUHEJmYmwJ7WZcwsjfJYXbYlnXj6kHspv7/3lbJ783c2sy/uB+qft+Ilku/ynhdV4
         +kSUhioD9fzNw==
From:   Mark Brown <broonie@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <YzIcZ11k8RiQtS2T@work>
References: <YzIcZ11k8RiQtS2T@work>
Subject: Re: [PATCH][next] ASoC: SOF: control.h: Replace zero-length array with DECLARE_FLEX_ARRAY() helper
Message-Id: <166428358991.365276.17332366204767237765.b4-ty@kernel.org>
Date:   Tue, 27 Sep 2022 13:59:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, 26 Sep 2022 16:40:55 -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: control.h: Replace zero-length array with DECLARE_FLEX_ARRAY() helper
      commit: b264ef796959cb65cdbc811da5ab950e33df4162

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
