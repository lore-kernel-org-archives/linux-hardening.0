Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007944BD78C
	for <linux-hardening@vger.kernel.org>; Fri, 25 Sep 2026 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790348409; cv=pass; b=SvXwRG3zpnaQywy/H6Nd+wFnIs7WeVR1mJsfwlsFsfZk2c0+8uJV0F7SRze66yo48YfK4orDXMcTFrW3+OEGmMVbH7hLnRcJB5W2gchIWrE8zykqFns32Q53nE+Y/f6HCTaA/iVZx7iTlhOGaNl2Wx0pv+qmIZ8SqyQd+WzVoYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790348409; c=relaxed/simple;
	bh=G7PD1SsyWtfXJXkRv2FlPB9lAjfDo8cMbMk/Mdw9V7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HlbaAqPcCuIzBcXmEV4xsPE3EExhmO64o/avSIVUePKodwXHyU5s1EZ9qN++uu1QptugO9BUw9ucy1ERT6J0cLWgxHqeSKVniXOewrmhKT37EwNQ4GlPqmmaTWNFCvNal4anIiOa1nM5AtpxH5PyfPPg9jXj59W0Zox7E+n/UQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=VU+craBP; arc=pass smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="VU+craBP"
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-5329fc7e0bcso11364401cf.1
        for <linux-hardening@vger.kernel.org>; Fri, 25 Sep 2026 07:59:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790348391; cv=none;
        d=google.com; s=arc-20260327;
        b=c22fyB0ctWtPcCMEUUY2r2R7BwU7l2jTCYIaOpMGYR67GVuhAxUMG2a3gYrdg2P8/4
         rO27sowNPup7j7BATSKtr1O+QZ6QYE9u+UCdyiLB3Cd8sWXCqd+KXeGvghanomAJ/ZfL
         ipPPtNLKHk/YqMQU321LtD2N+AlUs/mqLxMYNhBGbj6W9mMVD3HOehPNRKveOSWDZsLc
         re9QAKRop+XAQEYUM+atHw+DaEkLnDX0g7Wn7DQQKWaceA+5i78EWTvRoU76nhRyMuOu
         HqM/TaUYlR3QN7VZn7fefXFKapCToThNz2Nk6DrCqlh89wxnWugamQ+jn6phkIS3kTVL
         cCTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oNCxj1Tkne1Dd9zOhmWp2sMzjpmd3KFTSPzHbdHwTl8=;
        fh=yfXwwabre9XsCwKeWJ07GTxOP49gpAQol0/AQWUxJZY=;
        b=G9JVrKEBtnCKfmEgu03FXRrloA/opqotZlcko8RgSPtOjHuOwQYuA6fXXFg6m+qMZm
         trZS46hPva334b4keM0R176GJyujtTskjv1cAv2MMTXxN35b4Qhq+ag569K79dL2CqDj
         +WClUb4wcvgehxM0/bsmWjVLe6zI4hMzDAOPecXeB6ShVXv9sJNaAs+a/kJjPW5keROg
         dQD+wPJT8525KG0pMgIPzpeq5Z8lCMOLFR4clezhUFcf8bhkuMUwyNq9SJ9MzQqqS9aA
         pa3pR+vIwpQDXeFIA1Q9PqocTm1uok9xKcMWCZ1UyFqn7TcmAlwomZd3aTs8S2uN8/RC
         0SZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1790348391; x=1790953191; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oNCxj1Tkne1Dd9zOhmWp2sMzjpmd3KFTSPzHbdHwTl8=;
        b=VU+craBP5sTfmgsks6GqGyE/aSlKFV/uYtDlbeOzYSOfhZM0LCRTW9xsMii7u5DKPP
         ee+c9I/OHN3XyjUODNRuDCK0Kc+tq2ddcB9We9B5h0V6rfU7Ena6Hzd3gZ9r2rPCXGqY
         gWDr2/Ff5lGSfoHuHqx1lh1188vB1iCslgZSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790348391; x=1790953191;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oNCxj1Tkne1Dd9zOhmWp2sMzjpmd3KFTSPzHbdHwTl8=;
        b=cuoaQmeYnvmvU2BwObOjPEm7E2sANtdXcB3Sxy8uWm+SO85TEEEmoKWsvtjGAvfv2c
         7VYxnf0QitIbSXY11P69dOSNvr7A0dYDbQNMKfzKwzQYpBBBCiGvq7/9uWzvYN4RLdm5
         eHcue7hHgitCBrnktDAEcE2EsVhv66BPSwiWHOLmsNB+8NYA4dYzeQM+qAIwHbNl/kcv
         mZwKrcWcTwAUfcl+nM4R1XXqMZse5cZTnUCsTxnNihzHMl1RekmaTqmWLGrdFlZCKtm5
         Hl1LD2p8l44j/ssDgkAGaWgma3pym+kn3+j8atMFTfcg+g9sGTWkbbmh3/zW4TrDA8gq
         7aUA==
X-Forwarded-Encrypted: i=1; AKwUvBwZbbKbHgBjgmDFz1L15+mwpjtr9eJKLuENsm/z1JCXNNzr4Bbr4V1fVbiN9fmse9rUigmKya1AeNXot2DPQgc=@vger.kernel.org
X-Gm-Message-State: AFuF++lPSNgM2tDB1EeHkiK2zRfZXIvY2Tv7dycUe6FUAPNaiZKozD1/
	KWIojsXK3ya+F79rNHl2Xwxn7HqzjndOYbPJuDVGAMQyyEItQnX7DCU2NUtugZEfvyeW3rfQLTW
	s4TxFZTI5+9ruLwu4xUPTXy3tsidt9NNKWTAl/A4yBJ9mU2/KX0o7
X-Gm-Gg: AYBFou3rmpGp1s9CGkypEBEIpqhjDqbQqO6KLF0tR5nMg3dKLTMT9+ZPA+gPjNEG9l0
	M4PFPzDmaQVVb1RuQaZQKS2G5Xd4KX24T6Yk8oXBD5bo0lvSyj+KYnH/rM+GWsulxDGz9VQ37rq
	H6FJf6+UejRdI0K6gsg6p4b/kdNIHcC/g0x8hPRa5SyIYjdhEBYxLiTQJYwdo10gy/6oyoCxNpb
	STlJnSz4tPIYW8RNwLQlRR8CPZY8rM/8UWN5A29vVzqawscZgUi3kYR7F1bpbsILveGAa5/9mg7
	1Nc+mFDTgdvrBh1GbrH5YdMj/ZvahHuTZkdMZMS10ckIU9IFSricTdCjc15TWZ25TAIsSWu91f5
	43P2ug5/w2A==
X-Received: by 2002:a05:622a:508:b0:530:2cc6:c8ad with SMTP id
 d75a77b69052e-5330b5ad6e9mr51539751cf.19.1790348391358; Fri, 25 Sep 2026
 07:59:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910235110.3922068-1-xmei5@asu.edu>
In-Reply-To: <20260910235110.3922068-1-xmei5@asu.edu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 25 Sep 2026 16:59:40 +0200
X-Gm-Features: AclHuK8PxhLjayeNK4Ioc2AfP1egLwmVYg_0ZofucCJ6SB6GJuae3F4l1SVQLt0
Message-ID: <CAJfpegsxW3gf6Dj+zVKTTHx8bsASXiMboZ6UWd5WWtBMqd8WZQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] fuse: don't BUG when the copy buffer is exhausted
To: Xiang Mei <xmei5@asu.edu>
Cc: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bernd@bsbernd.com>, 
	Baokun Li <libaokun@linux.alibaba.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Luis Henriques <luis@igalia.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Sept 2026 at 01:51, Xiang Mei <xmei5@asu.edu> wrote:
>
> fuse_copy_fill() hits BUG_ON(!err) once the iterator backing the copy
> runs out of pages.  Over io-uring the amount copied is not bounded by the
> payload buffer the server registered, so an unprivileged user can drain
> the iterator and panic the host - mount a FUSE filesystem with small
> payload buffers, then setxattr() a larger value:

Applied series, thanks.

Miklos
