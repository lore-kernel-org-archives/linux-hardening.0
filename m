Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95B930F957
	for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 10:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719620; cv=none; b=uZ2Vgar1jjprXwmmzTYAOloZNvCyWX6ubiqe1wFK9O6RPs1z0dLxstbFOw2W6WkBuxKi/OWZtheBWHqsrkl6Qv5gOtuOI6RGm+zT2OZVvmNLbuH5+k6tk+NC4vzB9KbrOgXUcJ0syqV/HsrnDiorUodIeZJkqRkfHLBJTTqzrdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719620; c=relaxed/simple;
	bh=Y1L0+y505YgChJ88kTKvVh2AdNyK99G7uNt6DKubeHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBLjhUYIv3y6C+2PQIZlMY9jLqGI7+UP6Devli9PelX/OhUPpldAqycoOnISsqur3OqyvVsruXizZ+bQ5qHFRsIoUrsze1UnB99axlUm0iBvsqHKivZ54axDES6ODqeBH6Ak4WcFdTCeHVOqvDjMv6bw8WYLf68sXwLAogaBUOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6vMvJNF; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6vMvJNF"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-343ff854297so2636853a91.1
        for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 02:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763719618; x=1764324418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCNoZ4dRyXS+FDaS9bTbZT2/5dpNe39o/44FrsZFON4=;
        b=L6vMvJNFeL4dZ8Ukq7vvKW5UZ06GCxk28w07qhOlv6zcDiXEEe16mfd7wjYphrCkgB
         C35qPdkT8zjTyIA7mthQo6J1nxIH/Liqb4SCGKzdS+jiuBgslaz5+w/mmdqtND/hoTS6
         tIs11JG9kR2y9zy42bedCDLSO+Hdt9pfStbuPBJgSowVU0tLcloH2ibAHp+L7b5cml9A
         S1JIjzY0BXLP0wvgKOfLGRB6+ehvt6acx9z4ZdSveqH679SF+YBwFiDOOJiiAGrqpaFl
         V6GHLuRHuR3n1YEZs7i/gUCKowmaeLocKeVVVoyiEzTXg56BzVl6ISpVY50Hsr/96avB
         CdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763719618; x=1764324418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mCNoZ4dRyXS+FDaS9bTbZT2/5dpNe39o/44FrsZFON4=;
        b=a+O16XRojE5wiVnJcP2Ce+F63w3M4GCxwPzuKFTwlVOc/o4a2A65Of9cLO64DZcs29
         x1GYoG0+z9xqZBu/wvcx1Rk6qwAGDneRDMTXNlBcpifsG8XymvTwvUnnymog9jU93Bao
         YWdLACMU1c4TYXdWgL9kNV+3j7ODAqaES6bnH8n2k9Gt3/o4cJXmmL84uP+ebWy2/1o4
         I6CqGSdxMqCfORS4tqgPYRMuz3tagfoEUX5HFJB68h7557gqLt3zD7VZ7dNkTBEXV8dO
         gNcAXklZPMtk9UGIFS0KPIfC61Q5elO5dEUcqi2pXVr6RQthKt2jjO/MTOF+YI9YqUzC
         fAcw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ8Ja7bRu/MdKkqLjzY8tOz3yS7EJARfzyaiZB8KfeP/Auzx19MejbUN/GLnoV7vXXESByWvIHNOgzSqPGjgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Sf68FaEJ+e7P/ubP6MsTy2mG+TRZgIjBHkiXrY520yBEvhQp
	v7INElRAh8ch9l68I3v1PDM/I4+WUw/rl8mWiZlRpyyIxkUN1ITQbmqC
X-Gm-Gg: ASbGncugein2hy2HtmR/FwO758lpegV9PW7ENDfAsQO46BBO1Tp2A3aWnpvbzzYWbCH
	/nFRFCpT7T6Li+Y/b1Yqw9FWFU5EJ5/CBU/tQY0VslecTiuYAeCPs7gV+Ts/H1Lsnqsup20Jlms
	4hi+fEFV2043adQ7c/TFQYcfQyNXznFDpfCW3Pjz0LoxNZqgsY8oQo5IHUkhZciksGJPos333bK
	a9PWCz+Ym7hSrrZQM3SI/3VSnidEHjjNqyjAJi+iTanIuRqcNuYjeIM0MavfvEhkAH3QFX+fuGX
	h4a3mAmGIScB/fpYDfGPWvtbfvIAWOZmqPy8WiqY7m3PqINf/dF0IGrSAcNfv27cpJEwcchIJHm
	52ESnT9oURaO78cjueFB8joqznOYHLXi2GCUnbULShGoD75egK2AkNu9HAiRicz7f4D349wLXoC
	u+kBJcgXcJlIXPOfo3MQUOaTXxxfenYEyz84dXkn0EXw==
X-Google-Smtp-Source: AGHT+IFYPoBuMPo4ymRkW3gUOnn2CpfpfKLAEIqUhCtAW959aOaUDxEHxh5S3+CFp8pXWSWDXx35LA==
X-Received: by 2002:a17:90b:54c5:b0:33e:1acc:1799 with SMTP id 98e67ed59e1d1-34733e74d45mr2265466a91.14.1763719617935;
        Fri, 21 Nov 2025 02:06:57 -0800 (PST)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-347267a137asm5234351a91.8.2025.11.21.02.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 02:06:57 -0800 (PST)
From: Zenm Chen <zenmchen@gmail.com>
To: gustavoars@kernel.org
Cc: Jes.Sorensen@gmail.com,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com
Subject: Re: [PATCH][next] wifi: rtl8xxxu: Avoid -Wflex-array-member-not-at-end warnings
Date: Fri, 21 Nov 2025 18:06:54 +0800
Message-ID: <20251121100654.9125-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <aR2I9Sere0W-4VZz@kspp>
References: <aR2I9Sere0W-4VZz@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear maintainers,

With this patch applied, my system always freezes right after the rtl8xxxu
driver is loaded. is it normal? 

OS: Arch Linux
kernel: 6.17.8-arch1-1
test devices: RTL8192{CU,EU,FU}

