Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bpbq/bd+"
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FC110DF
	for <linux-hardening@vger.kernel.org>; Thu, 30 Nov 2023 14:00:31 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d048d38881so5302075ad.2
        for <linux-hardening@vger.kernel.org>; Thu, 30 Nov 2023 14:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701381631; x=1701986431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHox1E9tNMDh2WCvlA3Q79O3YlEbU4KfGdr0hP3kvXw=;
        b=Bpbq/bd+YEvVDZmZExZw6n8VR5z9JHmXXOHYjYf+AkgtNPxAsudaH+gjAaMXBDF5+i
         H2m3vjiDe4WolZCkDR+THlrngR0sY7r/sXcyQRFs9eovX8f8WGEVhvWEo0tuqcxM8MGG
         qPzk7+MzcHLrFd7slFCsfNPLVsRgLRx3wi1pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381631; x=1701986431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHox1E9tNMDh2WCvlA3Q79O3YlEbU4KfGdr0hP3kvXw=;
        b=KF3s/2iHnMl5poHgRFvj6MKAnoGELj+kr8j4MmiYSeZNLaOjBMBEY9cNrW5covuRRc
         Lru2JunUS2gyTNcaXoatsm+JRjdQv6GoagLcfscRb4XvgbFtki8FjuHnNXsnD5mjYWb0
         trPsQeWok9FHXcWixxdXHa7SymVsEIHWk1I0Esy88F1JekBU+E51yxI1KuwaEdxdpw0y
         Ldu9xFsj5AF72L19eFERk+DpPUJ8YtF99+/16PNUN9LQuTC2gD84vIw+ndil2mDpo4iy
         Co19ZcQNPCJLfiwUrWugMAQVOsZv7hKSrJvE/x8mHCxzpB0dZYlVfO8L9M9C0seEBLmJ
         wrcQ==
X-Gm-Message-State: AOJu0YxqKxNFnhTww8cvmTlCmD9yXGvdCV7eXxggXpUWojd1icP2akj7
	K3UnhQv9L06eC8kDErTJQ2yyUA==
X-Google-Smtp-Source: AGHT+IEtmHKikrS9bAIhRsCO0Z6yTqGcvTktzJ6uknKaVIdGzoXLj/KkG2DshpCtw3r39an85r8otg==
X-Received: by 2002:a17:902:ea11:b0:1d0:3f5e:d4c8 with SMTP id s17-20020a170902ea1100b001d03f5ed4c8mr3088019plg.30.1701381631312;
        Thu, 30 Nov 2023 14:00:31 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ji11-20020a170903324b00b001c5fc11c085sm1870985plb.264.2023.11.30.14.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 14:00:30 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Shahed Shaikh <shshaikh@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] qlcnic: replace deprecated strncpy with strscpy
Date: Thu, 30 Nov 2023 14:00:28 -0800
Message-Id: <170138162711.3649080.9337007847087027672.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012-strncpy-drivers-net-ethernet-qlogic-qlcnic-qlcnic_83xx_init-c-v1-1-f0008d5e43be@google.com>
References: <20231012-strncpy-drivers-net-ethernet-qlogic-qlcnic-qlcnic_83xx_init-c-v1-1-f0008d5e43be@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 12 Oct 2023 19:44:29 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect fw_info->fw_file_name to be NUL-terminated based on its use
> within _request_firmware_prepare() wherein `name` refers to it:
> |       if (firmware_request_builtin_buf(firmware, name, dbuf, size)) {
> |               dev_dbg(device, "using built-in %s\n", name);
> |               return 0; /* assigned */
> |       }
> ... and with firmware_request_builtin() also via `name`:
> |       if (strcmp(name, b_fw->name) == 0) {
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] qlcnic: replace deprecated strncpy with strscpy
      https://git.kernel.org/kees/c/f8bef1ef8095

Take care,

-- 
Kees Cook

