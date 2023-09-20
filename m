Return-Path: <linux-hardening+bounces-2-linux-hardening=archiver.kernel.org@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482AEC04AAF
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Sep 2023 16:58:07 +0000 (UTC)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 819831C20BD7
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Sep 2023 16:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72923E485;
	Wed, 20 Sep 2023 16:58:05 +0000 (UTC)
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789F479EE
	for <linux-hardening@vger.kernel.org>; Wed, 20 Sep 2023 16:58:04 +0000 (UTC)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7999F
	for <linux-hardening@vger.kernel.org>; Wed, 20 Sep 2023 09:58:03 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-414e78cdc11so46866271cf.0
        for <linux-hardening@vger.kernel.org>; Wed, 20 Sep 2023 09:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695229082; x=1695833882; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i6XY8wIMD7LjGNpegRcCUKrZA0w1gq5GxQRY7mj2AIc=;
        b=ZwSL5GNvCI2o/zJ+GAZLiR+zbSb1Aco0xq4qFO7Entw6yuvgGOZcG3MmVdDG20ry8B
         UK2WYqEgAlcEsVE8D26QW/q6EKJw0riOwSFgxi6kTELXgM0vSpsocg2fTh5caZfY/B6c
         WEWpXN/QfmMpMZkJ9qd3ytKW+DWmNEoSjk/Kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695229082; x=1695833882;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i6XY8wIMD7LjGNpegRcCUKrZA0w1gq5GxQRY7mj2AIc=;
        b=OMDdI/Xo+e6AqwW+GbaR1Xv48+RwG2uX9z9/5ymbvWApCD3B2TfB1H4asvl/RK26kV
         VrRVGXiO2qRoNYCRuezKolb2kbPetiCwcaLBua5C9XPOfu5xcnFM+ZYl9ce/nOrvqbIO
         aXtR+9HWZyfObOf7Zi/gzI2lxmbe63FKE7cpEmsRjWPTlKCqiIifG6sfcnkZE21aDeUE
         7e5kaJ3JoOY5wxmuiSEoposEQYg8D2owLb3PwsxdtLozeGuf/WtYSCZC30B5wZz+Asqu
         O/RYZHu3n+6qniDesLHttniiKfnNh6CiHioPZxJ+I7EhX0Si4UZv4ZR18TD0DwnADCYp
         QMcw==
X-Gm-Message-State: AOJu0Yz6kfJTd/hji73SmLBPGmtKOts72IFq6L/j7oTaYVBhSgfRwnpD
	no9zcc8VVJJymR5j3aV5gSt1U5jnamO3nK/s3yc=
X-Google-Smtp-Source: AGHT+IEVnYX/vWQ6wzpuzJR4gQuNWFS5OV6usmKG5Dd+4W5oT60gQADeuSffocgC/OW8BLei+Tkd/A==
X-Received: by 2002:a05:622a:182:b0:410:9af1:f9b2 with SMTP id s2-20020a05622a018200b004109af1f9b2mr3862301qtw.3.1695229082186;
        Wed, 20 Sep 2023 09:58:02 -0700 (PDT)
Received: from meerkat.local ([209.226.106.110])
        by smtp.gmail.com with ESMTPSA id l25-20020ac87259000000b00413152fb99esm4714875qtp.49.2023.09.20.09.58.01
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 09:58:01 -0700 (PDT)
Date: Wed, 20 Sep 2023 12:57:53 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: linux-hardening@vger.kernel.org
Subject: This list is being migrated to the new infrastructure
Message-ID: <20230920-stoppable-royal-e46a54@meerkat>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello, all:

This list is being migrated to the new vger infrastructure. This should be a
fully transparent process and you don't need to change anything about how you
participate with the list or how you receive mail.

There will be a brief 20-minute delay with archives on lore.kernel.org. I will
follow up once the archive migration has been completed.

Best regards,
Konstantin

