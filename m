Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B9F383338
	for <linux-hardening@vger.kernel.org>; Wed,  1 Jul 2026 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782926117; cv=none; b=Nv22rQ4kJaqGIN5OXsOrY36nwEvzai9Xc/96a2Auk8zlpBC/E6KgeIqh0pSTBgJehZfs/VfTFcg5ViRdH8Am9dSfNzP1Pb2WZO411Cq8lVk53Il2tQA4fvCMRfovK53yJ2DLs8aHbcDiPHbLPeJ8kUa+DY6LHXGfUruH3RuG1ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782926117; c=relaxed/simple;
	bh=r5j8jAU52xCxPnc3K4cdDtHFT9hkocfdMqu7pwNKuyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3F/5wufsC25LX+JqUJLMF+WWydfpLe9TIHiOnttzswNOtMTDzRc0kwK7TEiOAMidBJLym/Q/Y+7RJuwU5UyW/0H4KjvgO1TG+ZXQI0XAbiOEcujtOv+8OzKrJO1SJ6ZTJHzd8t07H32wbGeHhV/1kcKdeVW/8Jqwm/1L2yFl4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2I1ALK2; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2I1ALK2"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c8fee9f63d5so417355a12.0
        for <linux-hardening@vger.kernel.org>; Wed, 01 Jul 2026 10:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782926115; x=1783530915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r5j8jAU52xCxPnc3K4cdDtHFT9hkocfdMqu7pwNKuyc=;
        b=B2I1ALK28TtH+4W6rHtocGhqmOlUMZgb8ylo6IEvnCwY4rnYHS5QzfOeE99HpzMbgY
         /ZanYe1t9O1CzUhxUe6w1CNJBXwXXnO9Ft7WiypFvaGBoUYUCqL2PZAiiyVH84wf6MQw
         rmEDjxIUEkZXrYmlx6XZpSqeaQeyFvjwtMTv5QKWpa2GaGi51a+vFkeSWk2ekbFe2XoW
         761qcnnjIukjI5E6iOVsdD7UAwGWzxSxhzfn9XiowLaqJwGEQrqHjBtJQwwIkdnIcQXp
         XQvu92nSEWEV8LQkUIXmq0GsYaQvs5oQgEbG870Do04Bn0Esks5wxEyf1pOuJlUC5jXm
         baRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782926115; x=1783530915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r5j8jAU52xCxPnc3K4cdDtHFT9hkocfdMqu7pwNKuyc=;
        b=F3vwG4pmvHWhWazUyRuZhJuC3LubLWnQJfGqa8FAdqBLflql19TF9iRL21IAAOAPtT
         pvH0s3WatqvXykeXjPC3tAN2VzJtOLkVze++PZy3S8/zsJacaZ0zqxY06gXi1/uPyr7b
         4COFuvQHzBNoK3OhVbV0Xiz3tjafgxxXHenMJZrIn9a/31qPEw+gATuHk68xMVu2TyZy
         Nj+LIogexfsMocas1Us5Dtz8jxTbG27WCILO0u9KMOce76wxtLAep3YTbfdMly2bQ3FW
         FaKcUwJxqmOI8k6lKaZCI9iBaWzaF3zbpMZ3K+QEZMVTUOTq1tvyGOOFWpRbRfWULkXg
         xAZA==
X-Forwarded-Encrypted: i=1; AFNElJ8CRznsO7EvW6MH3JBeQ8Bw5HCRbUoggVVyto3e9nRGRoDx/BS/Z3PEHwYPurmwPyUslZhIimE5klVK1zgXm6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRChmKwYrZmIdXCKva91iHbkQhnXEiMfKA11SE5iEbu+N79mKT
	kfwNjKCfqkKqORHhOaZBgEiA4OaC0OhCYAyEAZ4SHtGgU0BrIAPDOdGR
X-Gm-Gg: AfdE7cmytjRwZmtgsRTfVgLrzun3HmfGGPJ0VHMLfdf+WksAp1rs8oc6hwJOR+rQzBK
	Xik8YI36ybBRLVkAhaCYq11y6lQG3jbgFqHLGkJqhjJecyWQKn+LnZJVRSpx5l7ZLZrHCzGVyu7
	QDKcjW8E9oMIHj7fjMpfVVlpzvxCCqe294ZrT+dlLwf2dhw7yimGPx7In9el94hO/14XnBCjwbM
	e6Gjf8YJtVUWK5pthG9YLTlL69jlx1p/EWG6WH1lD4DITrOkHOwVRT5qKz7b/b5qf4PvHW30XC/
	BpHYju2q6trk4iK10bpLRcMt4lX16H4X2kW4BJPwF9ZMA9UAUwtdT48lcgcw/IgJ9k+oszKCJz9
	T+Dey1yNDToi+rAGb8IFxbHmlNsVSYos4/b/fcHy7B+mbd6A/mM5LVmYQuK4sdQh/cFxY3jpYhT
	qTP3m/9kCDbgXA+zPrdTJzHFZ+BzaRuhHa2+GnByQ+xZNhwWJWXArmjak=
X-Received: by 2002:a05:6300:6702:b0:3bf:b49f:53fd with SMTP id adf61e73a8af0-3bff402b5a9mr1914162637.3.1782926115066;
        Wed, 01 Jul 2026 10:15:15 -0700 (PDT)
Received: from LAPTOP-97G9G880.domain.name ([106.222.201.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee300e4a7sm21777940eec.13.2026.07.01.10.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 10:15:14 -0700 (PDT)
From: Karthikeyan KS <karthiproffesional@gmail.com>
To: andrew@codeconstruct.com.au
Cc: joel@jms.id.au,
	andrew@aj.id.au,
	Kees Cook <kees@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v6] soc: aspeed: lpc-snoop: Fix usercopy overflow in snoop_file_read
Date: Wed,  1 Jul 2026 17:15:06 +0000
Message-ID: <20260701171506.338614-1-karthiproffesional@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
References: <033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

Just following up, it's been about two weeks since I shared the
hardware validation results. I believe I've addressed the questions
raised in the thread, but please let me know if there's anything
else you'd like me to do.

Thanks,
Karthikeyan
