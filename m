Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C48DC2C9;
	Tue, 19 Nov 2024 02:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731982657; cv=none; b=eGJaAl6j769MAS+ymuExJu88ea2cCXVGl9s1Od7sb74+YjHvbSWmTyfpt+Q4GFZ7Qkvr2Nd91S245w86uv26Nx7ZdF+VmUygiFXZqxCsFMAUusHaNmID1HQnPI7SAj69pHtRtm1Q5YqCN8VsCr14m5CVhwZ7MMgWg6cXsyYSFvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731982657; c=relaxed/simple;
	bh=6O77RkxE3gcXrVBgVFmaaxWoOJeYfwTGv5ddB9OMSo8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j6/6lzBb/qcwrdrDUYSE//4xNjDsa9R7Sta7rcV21orPGJmlnGXBS/dyAJIFduo/38OmRm4Da8kr7qBq+ieJK6NDBG+pX+4yhPpj+oeYjQWLkJ1l8ODD4rrdiKIrAz9K3yOn/8U6suCPFYQh+gRhw2/2knzhD7dAReRtMSnNK+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUaAXTvY; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUaAXTvY"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ea46465d69so161415a91.0;
        Mon, 18 Nov 2024 18:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731982656; x=1732587456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M41CMe+QvqjaoJzwmSLJZ9eaj6N0XNl3L6DH/OPdGWg=;
        b=hUaAXTvYB1OAzudmEC/FRxuf/pYl+Ld6p8oVE54ezRmNIFtA258GmjL0sbEuBEPQAt
         OmVUbs8q/bfeA9WyPRET+Ft/Q/qPAbuvj/IwqelmdreaiKAfmWbmwvhw3tmhmQEIrv+V
         AYBcrumm4/Hxmu0fGakrRYCzP9jEjLppcRlhkJPpgGoIb0clzLJHfnD+aYatnmoZxKfN
         Q1Thb4WzC26QybBBhGFBP8lldfgvzA2Ill8I4lg12hIW1DMLMtnEqF/saz00ENqxkuuw
         jwFuzpNu6/1tGCV5WWz3S0Ih1JmOyB8OH7HgHyyCYx+zJNwg13/MjLL2pik203dLyQ/7
         KPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731982656; x=1732587456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M41CMe+QvqjaoJzwmSLJZ9eaj6N0XNl3L6DH/OPdGWg=;
        b=SajCUaj3kEIquAz3yOiRSfZChvkijOxuKrz8CRgZbNHR9ndAljgTeVFR9a7KDpg/vY
         MQU9PyD9xFczuRui0Um3nrcaHxWrnr7t3BIO62CJ4KWUOqk/PRA4wD2w/2/KdQ/1wgCi
         y6wYnKB7070ZyXxG1VjR6AtsU+7kfObAPYQP9CMMTirJ0BI25rEifOOBRx3I4DbHRNrO
         H90A2F/Q/1pqjljzk3s1MeUr6ZmUyRND5UVnZxdk+IvqjRuHcWaiB46V13AG6oJa5bSx
         xoPolIHjXxZo+kFKj13xR055gvucskir92EVgFcxn6b68LGxEa/cQr2Hs5qLAr1HB0GP
         RDTw==
X-Forwarded-Encrypted: i=1; AJvYcCVWAOvWGMThhoXISLP6aB47sQM5fT3JwbcXvE1Kr2sX16JD6ApZKxaRJ1hXJGcp6dkA47K9WGo+08iV0I0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfHBpBWNozCrC62FD+fghgg07JNWe0qDJBav5sJmQ9FuPHovFY
	g6zV3OpEu7DWFgeEiljDSZfpAgmBeo3b27qWRzvOONpODMcQ0zGY
X-Google-Smtp-Source: AGHT+IG0oyp4DRCOYL0HyeA4vsuupIRjL3169+A1W0USKRXUGtfuog7gaLvyxXI4p3JsHbZnEwH+bw==
X-Received: by 2002:a17:90b:1e10:b0:2ea:5c01:c1a0 with SMTP id 98e67ed59e1d1-2ea5c01c415mr3622339a91.3.1731982655663;
        Mon, 18 Nov 2024 18:17:35 -0800 (PST)
Received: from dev.. ([2402:e280:214c:86:d61a:bb21:5b09:2d6b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea024b82aasm8244129a91.33.2024.11.18.18.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 18:17:35 -0800 (PST)
From: R Sundar <prosunofficial@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	R Sundar <prosunofficial@gmail.com>
Subject: [PATCH v2 linux-next 0/2] lib/string_choices: Sorting function order
Date: Tue, 19 Nov 2024 07:47:17 +0530
Message-Id: <20241119021719.7659-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series rearrange misplaced functions in sorted order and add 
str_locked_unlocked() helper.

Signed-off-by: R Sundar <prosunofficial@gmail.com>                              
---                                                                             
                                                                                
Changes in v2: Rearrange functions in sorted order as seperate patch.           
                                                                                
Changes in v1: Add str_locked_unlocked helper function alone.                   
link to v1: https://lore.kernel.org/all/20241115144616.7453-1-prosunofficial@gmail.com/
---  

R Sundar (2):
  lib/string_choices: Rearrange functions in sorted order
  lib/string_choices: Add str_locked_unlocked()/str_unlocked_locked()
    helper

 include/linux/string_choices.h | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

-- 
2.34.1

