Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B517BCA5A
	for <linux-hardening@vger.kernel.org>; Mon, 28 Oct 2024 00:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730075772; cv=none; b=mmu2l4VSMK7+MgjUXKr37+MvorNDnEE6HvUQGCTrYlLom7hWzZDS6nvRQDulfjhMBaeqPFFfkJdArVry9dWXfE55+XCE/dVUI94R+8Et8ms85mv633JSjulTIC2srwpeVruLTICkNLoEdDXnCryEE8aRk9WY9/jJm46U1letH/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730075772; c=relaxed/simple;
	bh=Hd5GLAXp3ye3/4TWLWX6baeNpv4+Vy8H+HoPL8mosOI=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=cwQIWIamJItH95Ujz2S171xTO4xi6ja4UXH0G3zh/+dHUGKep3NffDhOgXahKneR0IvgtFSLd2lVA6B/9EYHtBVCIFCKKBLjNvyRuZ50ZVtHXp1na8nA008iyZTUg23v7dTsXyw55XvqFY37qPS6IsRPwpaQeAwBSMvGXteqw0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POEJuKbL; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POEJuKbL"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso467397466b.3
        for <linux-hardening@vger.kernel.org>; Sun, 27 Oct 2024 17:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730075769; x=1730680569; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hd5GLAXp3ye3/4TWLWX6baeNpv4+Vy8H+HoPL8mosOI=;
        b=POEJuKbLmYGyhl+ykTalIxiimhpEQ6iHXWa3tjy9Ila3mFSYR5C96V7jXzr9rAhQ1f
         AxXEXsM03hITxEh8V3RL1lGo/rTykJ74OBcH34Qs8JLDxK/L1ginHHMGkdGGOACQfOMi
         y5K2z90LYDUxnur3KQqjEzuyRV4oJ16zHIwbOIMaeP/ip8nubBS1E4DTfVO1ceMWagNl
         CBr5O7CBsW15DB7e0qtfRDgVqjW52ermctOibHqGk9Kj18yjrIFl8eJ28qp0LOXjSrk5
         0YaWSmvBA8IqJO/RmcnHC7w2tA4ceHfCiJcpseSFbwnMUJs4kanOb/jkvl6jT/Q95hqp
         v7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730075769; x=1730680569;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hd5GLAXp3ye3/4TWLWX6baeNpv4+Vy8H+HoPL8mosOI=;
        b=qcDNcIyVMugAqaqkYD3C/kE+hg1eWHg1m9jT9x+vGToCJ8GlIZpMRwmIbr5rTE1yhd
         egbzbB9I/c8eLWyiAC8oFRWTtGJVObBqtbgk6OWisdKnSyuyxznzUjiGFBr/4GU2payr
         QkgI9RPKdSZOtw/G6xsEWkYDWIN5ns2Btop7hie1/kfMmPuCu2ZRJeABgUYFDGbifzIl
         rKFmZsba7HyrYizxzAeiSYjLEJPdZK/g5+1V/oUshJZRWUDs909rrO/K3jEtZy6L87a/
         aDvLOE8h6XVt1Kxnw/VZlzLvVnT5IFhi5+QkVlQ6skcXIQjWzC/XIWzJA4oHqr22WH7s
         Ixmw==
X-Gm-Message-State: AOJu0YzU69HPAAYygtygYSUgB6CA3bCQzvpulzoDKowAdQke/f6jMej6
	4oF/038qSdSk4OeSc6R3HJSn9tyn8tyhS9LexWwjofeT5EwfP4L6zGE5+g==
X-Google-Smtp-Source: AGHT+IF3DfFQTqnScc1hSf3CAIeWJekG9BHCxXVUjjaoXD+wAsYv0Rgz0OCvpDNyHgQfmRNN7UwGfw==
X-Received: by 2002:a17:906:c105:b0:a9a:684e:9a64 with SMTP id a640c23a62f3a-a9de619b1damr680245866b.61.1730075768715;
        Sun, 27 Oct 2024 17:36:08 -0700 (PDT)
Received: from [87.120.84.56] ([87.120.84.56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b30c7ae73sm321577866b.164.2024.10.27.17.36.06
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2024 17:36:07 -0700 (PDT)
From: Kelly Hall <rebeccadavidson3678@gmail.com>
X-Google-Original-From: Kelly Hall <info@gmail.com>
Message-ID: <d16a891efa182d200232c2220f71c786eebfedbb59b1df28752942caed99697b@mx.google.com>
Reply-To: khallpb@outlook.com
To: linux-hardening@vger.kernel.org
Subject: Free Piano
Date: Sun, 27 Oct 2024 17:36:01 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello Dear,

I am giving away my late husband's Yamaha Piano to any instrument lover. Kindly let me know if you are interested or have someone who will be interested in the instrument.

Thank you,
K.Hall
