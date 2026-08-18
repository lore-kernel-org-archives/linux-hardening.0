Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A10E472F65
	for <linux-hardening@vger.kernel.org>; Tue, 18 Aug 2026 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787056100; cv=pass; b=KEvUZuIwSML1y/9VqW+U6NSewrWgBjUQP23ESqUceaL34evwSpRS1IzDmv33dLiD+hcaqDiWrY83P6W/a+VfjGscme3uHdT2Nv4q8yO/PaVo/b+gIpIj3pJENq1/G+gPVGxVHSFbpjN51bqMcUyUYVBjUR+wJuP5MPTgghOtL1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787056100; c=relaxed/simple;
	bh=2t5ruTH/FipDKh8OqaQCF5eNOVjeSsOw3J178x+lqNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NnRTtUJ5HLfH12vAUxShsESzG6sklb8kusxSZJ5MMVLATllXJwLyXBSHg3Nd7DWIovoSkP7uZ0GTL/V8Z+MilPvCbOv5MWHRKm+ei+LIhKKqGellOJ4txYJsOHrzffNgiKpJFZHBHcVCuY0Yc+uF/7Q3CwYsLT6k2Q5Pd7Nf/lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Po3VnARK; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Po3VnARK"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c16ac21acso28125851cf.0
        for <linux-hardening@vger.kernel.org>; Tue, 18 Aug 2026 05:28:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787056097; cv=none;
        d=google.com; s=arc-20260327;
        b=sgC86v1YaEwYTTCF88Ee3M8lxOXIFUExQOph2eCz5hLBHEQU+aWdrv2Ri0f9xe5CdL
         Pi1u7OGhdjnjpXOwMWp68mZ608HhcG4KqkHJZnW7i2ebJrcMP+Xplw1A6QyCe/kQxakD
         xLScyGDIaN8duoMAvcyTSm8WSImen/HKzOk19M3v+WwjbrkLyq1KkYNqIA0ivRVdwNe3
         susJnQmfxw4sZT+y1zWC/Rrcp+ChVrk2dustefLpLyH8rVxCumXuJ8OFMXtLYICaHvM/
         9SsSgI6NBQXM7q0EMhGtm7TaKF+forfeYpG33f5evjEE9p5P/qCLviWtrCj0fOBuFMmo
         HPHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Cs4d/aTAdPmhjV65cnsHlW0NYElIqRWTFffV0xAefUM=;
        fh=ruSKmxlH66TAkf7RGHMzS4+0sSOugTYClqmXmQZPOyA=;
        b=j4EbdxEe6yeskL4B+gXRtt6UCFJXdIe8qEdG2KcyZMxE01pYNZcgsCYrG3MS0QOvVr
         baLtbGDJ8pu4t6PQd1rjjpwS8WeX7OFZiHa6lsrePRpU7bPUSZ1OgSEqZoG8I7qog6AF
         6KobCVDHT+Kq1fUglj60G0wuTjkwiWvOT38QXXnAK4cps6Gj0srXywqHO2I6q27cySS9
         wDpW3zv7L3HCKl2BMsO/dCI/pKwq6fo3qS8r304JLo82lNND1KndUq0aGbLGDcXH05ok
         StCORkx/CLxPXv0g1wDFBuaya5/4ZzEmmE8coMhFme7G/s+YFxrWxJnGGutkndcqEZd3
         pZ/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787056097; x=1787660897; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cs4d/aTAdPmhjV65cnsHlW0NYElIqRWTFffV0xAefUM=;
        b=Po3VnARKTQsX+tVYMj9GjkrRDp3XlWHd5BQXoarB5hSJfWiczO5bPUETIOnLvAcKkH
         wpLNmRltpoyPjpJmt2CaX/LzNibn2m5TZwKC6d4SExy2Tz3eeyVsW4/Cr0IxK8aFsYrC
         boJ0UImPQBfsNOsTZPK7ZqQS5D5FjeV9R/JHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787056097; x=1787660897;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Cs4d/aTAdPmhjV65cnsHlW0NYElIqRWTFffV0xAefUM=;
        b=imDI52Tom0LDKHzFDTU9vXI4GkPWku7t4cQvq0qpNPDdvncksxGKNvY18Vxb6V7l4S
         7YxRUj2/wAHHoTxgUKOruLJRm+gmCXwE4GIcgk5K8VEx90CAu28yx7M1D2e4ak5Y2hid
         PhSGt4QnAT3FtDi91UPNupwLMugb2Ix1JHTXvUy4U0mKjLmr/Stnjy2TkxfWgiPYDuml
         4+ujc675PSzEPk+sDYr/3tUTR5HgOA/T37M4M3JozSVcGB8zkjqVFSTAWo9NTULYSjjw
         RvMFajytyquWXEcEmFpwynQS64O7vzx48hxJgKXTcHvTOz+VJ9ZYFWA7pNL9kOh6LuvN
         WSrg==
X-Forwarded-Encrypted: i=1; AHgh+RrwY3rYlwu3X/sy73sFKQ43/MG0b5b0pot6OEhMrQ7QQeiNh6E5XVHpBHJEI4KHxyjJGKe5vX5OaKwA5q9etaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEE/9dGY5pe4yNfrkwBOFGCoQBWTOBrMEMPrpu/ZEVjGvwXklK
	6/tHsmvfYxxPgqxlNxUkG0qajEEXFLPtHs3rvn5C1Co6ws0B3RdzdWlr3mFVvFGaPBuXu4Lr7+8
	N330rfOtW4646Y4GU+4dJKpJiu34FgmNfvhND5UcSKA==
X-Gm-Gg: AR+sD12h3FfruCp03uQlI9eeJ90VRCi3BICStei1rGQBXXINNPgEKKGtjCqMxfgSZ8A
	9fICPQsUyl6V99ogZYdvVnyVE2uPJeE2cmVzzkmPxuaPzt4GFNdfLik/JcSKz8cOKXqCGSfpY61
	Un/JNFDoOFXb3HD6OFL8kX1whYj4Wa9ynCyrXqSoCGyQ8j/ZottFCbsg01rgFq0rwROffpootBO
	T968aGKA7r0gXAksDvlNw0QprTxw+rbXxPbAhG0ovx8Ig1pc07FdJI6n32x4bnOt22qsGou5A8I
	JE0Emc5yhc/+iREuwo9a46136fSiMa4SY5wo6BA4b9JPSELxZNIDxJXtzjAGS4/7aL/dUL5z0ga
	5
X-Received: by 2002:ac8:59c3:0:b0:52d:6afd:7d9c with SMTP id
 d75a77b69052e-52d8547d028mr343984551cf.29.1787056096705; Tue, 18 Aug 2026
 05:28:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727233706.218446-1-xmei5@asu.edu> <20260727233706.218446-2-xmei5@asu.edu>
In-Reply-To: <20260727233706.218446-2-xmei5@asu.edu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 18 Aug 2026 14:28:05 +0200
X-Gm-Features: AcwNN1ViAlwrNDMh0sYUHfTW_N9xsab7LO-nyvgFlZMdK_NJrbjn_QJtzEfFsgM
Message-ID: <CAJfpegtvYJPBt=AcssH25mn5VDR3Gdkhf1PvuLR5HkJ=CmkYpQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] fuse: bound io-uring payload copies to the
 registered buffer size
To: Xiang Mei <xmei5@asu.edu>
Cc: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bernd@bsbernd.com>, 
	Baokun Li <libaokun@linux.alibaba.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Luis Henriques <luis@igalia.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Jul 2026 at 01:37, Xiang Mei <xmei5@asu.edu> wrote:

> Store the registered payload length (payload->iov_len) in the ring entry
> and use it for the import and both bounds checks, so the buffer the
> server provided is honoured and an oversized reply/request is rejected
> (-EINVAL for a reply, and -E2BIG/-EIO for a request, matching
> fuse_dev_do_read()) instead of panicking.

Can you please update this on latest fuse.git#for-next?  It looks like
some of the checks are already added by Joanne's patches.

Thanks,
Miklos
