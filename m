Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XvKRoBqi"
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D68719B4
	for <linux-hardening@vger.kernel.org>; Fri,  8 Dec 2023 09:21:53 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d0aaa979f0so18273405ad.0
        for <linux-hardening@vger.kernel.org>; Fri, 08 Dec 2023 09:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702056112; x=1702660912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EFy0vV+X2SwYGJQf+MCC3kNRROgyPGPpV16+DYgFvIU=;
        b=XvKRoBqiL7C5fXClblBmtpfgwi8AgMINKZiH2/vooa/uQ2n37epw//002hQDc+0xjy
         aF35qv/j4wDRbnNC4/qGYZjvpjumX+PlZBTXjWXKBpdNAWBy5VQqRHP7+dDxsTTPUYFY
         ADxX6CRTudomQURldo21Atph6Mq/UgCVCQBDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702056112; x=1702660912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFy0vV+X2SwYGJQf+MCC3kNRROgyPGPpV16+DYgFvIU=;
        b=dbPoNj/YKadiHwkkpESX9ABCdTMUuC9ip1o+rFhqdNjRrigcUMsrXtP7v3PM+DDqqx
         8E/gOQu0hCLEYh+DUgDYPqarQKnjZS4zBZd/nq0rQsy/n1olz4grvBTrIEePdV8aqLnT
         I0+Bp5yoYGNTgLMs5UPaSMoHTn0740VG2ttOebkbE6JwMQvQZ9iuyxMQ+xVJa51nhW5U
         7pZJTUAbv8YV0R+L9DaC4ZSc5IhC2Lv3uLXS3p1OO4/8BXt6cGl8ql1x7CK/BRYm8Kfo
         thCGXmGl3x82xclfanbBR+XCC87mE8FzQKP8TEXX/Wpp5V1Qv6c3t0U6gZcCiH9vBWeA
         7SbQ==
X-Gm-Message-State: AOJu0YzmOEwenhO8i4iUFbgbm4u0tAt2TyHS/CSEIvSc5k4CyBz1p+3G
	LoKTYNMxcLaxIODFGWvRPl80QA==
X-Google-Smtp-Source: AGHT+IFBE3zMPa77AhEMIyR54IrCSnVfAxz3tKxrhVSOF23+vSFk1//u44z50ReWxtHlwvW+MceEOw==
X-Received: by 2002:a17:902:eb46:b0:1d0:71ab:b9b4 with SMTP id i6-20020a170902eb4600b001d071abb9b4mr338136pli.90.1702056112529;
        Fri, 08 Dec 2023 09:21:52 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709029f8e00b001d0d3795b25sm1945089plq.172.2023.12.08.09.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:21:51 -0800 (PST)
Date: Fri, 8 Dec 2023 09:21:51 -0800
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Shahed Shaikh <shshaikh@marvell.com>,
	Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] qlcnic: replace deprecated strncpy with strscpy
Message-ID: <202312080921.112091F614@keescook>
References: <20231207-strncpy-drivers-net-ethernet-qlogic-qlcnic-qlcnic_83xx_init-c-v2-1-eb1a20a91b2a@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207-strncpy-drivers-net-ethernet-qlogic-qlcnic-qlcnic_83xx_init-c-v2-1-eb1a20a91b2a@google.com>

On Thu, Dec 07, 2023 at 09:42:22PM +0000, Justin Stitt wrote:
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
> There is no evidence that NUL-padding is required.
> 
> Additionally replace size macro (QLC_FW_FILE_NAME_LEN) with
> sizeof(fw_info->fw_file_name) to more directly tie the maximum buffer
> size to the destination buffer:
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks for the refresh!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
