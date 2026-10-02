Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0F63537FF
	for <linux-hardening@vger.kernel.org>; Fri,  2 Oct 2026 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955991; cv=none; b=duezfTPS/SBePP4w/C3WkRyMHPio8uUCielBzNT89veDvXncjyOIptgRIbvQa5BTWG/LAi/PGuFGciSkNZshXahozNCKPSWeG/Kr1Hn7UZSp4ajauurHJyHX6olfedJjJFDp7+h2ejPCS4ZR4WhTX6lv2dsoD7333GDgz05EcbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955991; c=relaxed/simple;
	bh=h28xSIp17OKs/AgiIrNq+DdSPKZiP/ZhWr17OJaw6v0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iXz1aePJ/RXQyWoTen7/cs8GfWO0RqXf7SkiptJ1da8nWiUI6rVLF8mpVioIAFQKvHE76yLZ5tOX5ckNsPE1L2hzqpjzYVa2iuaf2kmag8Vf5ia6TtGYHRFhScZuSZIdoHJXfFaP7Qh2tJHfnZJEaStuZUnwIwF/wSdmqpgyFeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=boSRXA0u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="boSRXA0u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790955989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dkAUcAmviJBE+AfFgIHguRjot4BcqQHezlPnJllPFWc=;
	b=boSRXA0uww2VevY/aVLg9v4AFUOOzUCGmolfLvfnq+FOJrGXiTQXexejCYMSHKsAFJsGmn
	XDooiy1VP08H2BzSSb5BmCVuWx6dez890OkGDwbHhxv6CQb2r94iwiD85F48MMpiQHKc/7
	gesjC/rcFrriTGYnv+ef0oxGCy+d+18=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-h_OPafmZPe-EEBAS-eT-1g-1; Fri, 02 Oct 2026 11:46:27 -0400
X-MC-Unique: h_OPafmZPe-EEBAS-eT-1g-1
X-Mimecast-MFC-AGG-ID: h_OPafmZPe-EEBAS-eT-1g_1790955987
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-917a510b22fso866246d6.1
        for <linux-hardening@vger.kernel.org>; Fri, 02 Oct 2026 08:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955987; x=1791560787;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dkAUcAmviJBE+AfFgIHguRjot4BcqQHezlPnJllPFWc=;
        b=yIqPBPH9edIioAoQ8ap1GlhrgXRarifCRiCUJyEyfzsNTQ4ohe3ilMQdEz8VqK/USO
         XvdMqx86h2+6dngMX9LofkaCGF9K5cGmABb0WIX1HBxPSnIvI6nXBq2WmDvwhIsB3zo/
         vDBUqdluTZ9WPqUnSwFq72iODHiUqtDR70Q405/gyO8B99QG62hNoR/IgQRUg3KNTgS1
         tYzJAfD9Rcc0YZriTfOam/pLQMXJFlrtbVR62EvxuHzu8ptgrwtdcLlBVAqq148Sxpcl
         e4Lnr+5E3y/3EKDqN222/RhhKZpApU16Igf4HYM4vRRAwGpLuhdini0dcBiAJBIKtDQi
         ICdA==
X-Forwarded-Encrypted: i=1; AKwUvBxOKrARzVin2gtYicECJpWAKxOZlfRHgBA3ZnSpB/haS4zTwjhYMRwK7c7B7MkrfVID2PHpoLo2Cc7qJs1Zvdo=@vger.kernel.org
X-Gm-Message-State: AFuF++mmICuYTqNZHvAFvdi6zf9Ew6iYKvgeC9CUriydgOOCk0jCpFxM
	gwplS+JjdAgZXGvp1+WUfUH35wEAV0ME7LlFGK/dBqsUVI+82eYuaZfhAIKHDu413dNiErMk7KI
	95Qq4aPxqoD4c/lGPcD071zIJG1HLsH+yY8X9sumySTAhskkR//p6h9d/IAjBvassGPRNCg==
X-Gm-Gg: AYBFou1HrSY8KQNRjMkE4Ng0OpAo753qRAPgqf3+Ifr/lQe8qXnEkAifxJ6Di4zn3sN
	zf/Dtz7N/auk+WiaDsNwUxeX1EAZVNEbJjwS/WwlsyEzR5yM01hgfK38pYmtgCkyvPPh+aq/gHk
	/85Wwc5gee92I62oeSNtVi8bNbOAu9nvFBcOnGNG3bhabFJKBLJEuFvGdGoVqWxbYaY+RGige7J
	D0pP5YeKhDNGykYxQKtl4T1fniLsela0ybt4+iOHLHdBPqYaJkMZKHNA3afmrMxnpOu+hX9l4qM
	f0b/9lt19z//smvtyep0wV3j/LEq8niblWC+x1/talwKUHYqVlA5sjOmNj7uWRYfWVRnj+MGUmD
	48nMRRQWJXAMT1K/NMe0oKOY/XCQqc0BY94nIgVgKyM3fLqHiG+g=
X-Received: by 2002:a05:620a:1a13:b0:93c:c98d:e1b6 with SMTP id af79cd13be357-93cf178a238mr541163185a.48.1790955987056;
        Fri, 02 Oct 2026 08:46:27 -0700 (PDT)
X-Received: by 2002:a05:620a:1a13:b0:93c:c98d:e1b6 with SMTP id af79cd13be357-93cf178a238mr541159185a.48.1790955986487;
        Fri, 02 Oct 2026 08:46:26 -0700 (PDT)
Received: from bmasney-x1.rmtuswv.csb (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca209601sm250629285a.20.2026.10.02.08.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:46:25 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
To: linux-clk@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Prashant Gaikwad <pgaikwad@nvidia.com>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20261001054701.39160-1-rosenp@gmail.com>
References: <20261001054701.39160-1-rosenp@gmail.com>
Subject: Re: [PATCH v2] clk: tegra: bpmp: remove kcalloc
Message-Id: <179095597991.810253.6056329084530494982.b4-ty@b4>
Date: Fri, 02 Oct 2026 11:46:19 -0400
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=267; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=p9s0POduzL50uWCzmc8L//0zD1FZFy8osEfnLmwPpCE=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLL2X7xwlD3q0Mk3N81nbOcpuVDJ4shx5VqkofuNK0t8q
 5zkd/vXd5SyMIhxMciKKbIsyTUqiEhdZXvvjiYLzBxWJpAhDFycAjCRac0M/7NLc2IttmQFTU5a
 uPWu9kv/HRz/0lkjLru9WDHz87aLs/4xMlwpS5q7a8bS/AVXHn6vDbqh6rXRLriQfRnnxPz6rHz
 lB4wA
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 32F2xNKZTZ8qLHjVMOaC_ec7352a245ZS5ek7mWaeu8_1790955987
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit


On Wed, 30 Sep 2026 22:47:01 -0700, Rosen Penev wrote:
> clk: tegra: bpmp: remove kcalloc

Applied, thanks!

[1/1] clk: tegra: bpmp: remove kcalloc
      commit: 2fdfb2abce2fcc157de840949fa3e6af9e915363

Best regards,
-- 
Brian Masney <bmasney@redhat.com>

