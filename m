Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADCB1FB5
	for <linux-hardening@vger.kernel.org>; Sat, 10 Feb 2024 01:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707527807; cv=none; b=By1H3fjd2ImU8EVRzskB2gt5faFhwwP9FvQFgUlxX5d1ahHxCEZLOxxvaKcgLHQR0E8eoSaNBMkK7/Lz8R9h17FTJiHHiMP6+ctqctioteM1gi6N78FlVNFx6gP0ME3di2jRhNJqaDY4oOALJg3bvtAGJYLpnhb/TvZEnFb8XT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707527807; c=relaxed/simple;
	bh=LjE7ZHH8ae5qMsodwhs2U36vGYqe75wMOHw6PFWF9AE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IGKXXfI8ooV6COia5tMXK9WSihjvY1Nnx0Eo2fsLcpyzNjPilaPa8liUGPy6FHmPfBo1WGiibQfdYIKy/yiUNN6TjQVPY4hG0j7pQBZyH9QQy/0TZlFKBh4cT9y6FPklWXfw4jEiUyaWwT6Ndcm9e2LzGs3nP299bc8enXOuqB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NZ7z1jDm; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NZ7z1jDm"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so1097935a12.3
        for <linux-hardening@vger.kernel.org>; Fri, 09 Feb 2024 17:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707527806; x=1708132606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lynoXk2e8t7moiB6PjCqroJY6cl9fHkm6incU3soZ3w=;
        b=NZ7z1jDm8BAYWOvls8fjZytdpAhOtIo4n7VmIfugnwCHGnj5KrkC1sqYEhzkxpkrRO
         s/nxAgMxEz9JHzZz4aUVvdBubDZg3MfS4yFyfRFzy+h4knIfBAnixvDZGE+I7qFUPQxN
         PGzXYyijv5BlU17iYRUhsPp/oubxYKUJt4e9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707527806; x=1708132606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lynoXk2e8t7moiB6PjCqroJY6cl9fHkm6incU3soZ3w=;
        b=vIKQFA039NQHJDJxYbrQqJf5Ffax4+2lLQo+7r2dfpF8nyq0YeuWZNmE/Lit4i0hxG
         Y/23bSnVhQz+egDrfjV32O+GBu/VkjvJcIANHMCvNlW+rmw1mkJNk8GoFAnuEunTBPkC
         1j3ES2zHl83LC7F/13QNqbF+Klgi7J1ViEqdonq6ftXcaEhldnRgjMCXd+4FwRdcyhO/
         bAJz4mGKAtmFhensyykn+nxUSoM3ekaxfFtFps5xZ0C27pWD0ac2G58aWc97fIDrWp4a
         x8xsNbdyl/OX+7SWJjwPttYIrp6BGN2I5hEraL2QzRAJ3OMh5ct+LwpWZgOy1Rq2J9Gn
         BeFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfJWx6OJ2J4NgohiONbAid4bHFSkbXrlYtTxaaqwVkVsillJ31pk4D8i/kBLwmXWlLPXjDbOwMUT1JR2oSG0dAwzibRxYOV4dHglv62pSS
X-Gm-Message-State: AOJu0YxqdJIXKtl3D9/Dj+VtS02zynb3LLT8o0UbJNu+MkJ/itqLbOjY
	M7EyG7dykaSf/EpsTqNVAGRcrGIa8LuvfswaFalYJSBy/YJASWdZvdH6bDrFWA==
X-Google-Smtp-Source: AGHT+IEa4UolbVKatHcbt+cOYgbS9oWPYEU32EkcR9iaUPsGADdWcfzc/f0146FOB7f21z75zxUz6w==
X-Received: by 2002:a05:6a20:9c8b:b0:19e:a1ae:944e with SMTP id mj11-20020a056a209c8b00b0019ea1ae944emr1032895pzb.37.1707527805847;
        Fri, 09 Feb 2024 17:16:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXbpj9X4EW+IsuXY65W8NCQ77Ve63MRwZ9v0hVMOEFlWHp6XsrVDzXNHjRD3/EjbLMLlTi8GajZ3krAQxM+apEYMuvZh3C/BXJW2Ul2A87DIpaLw9uKIKT15qBRGr0uCY9gT6RItdAsLYQnMU/qdyLyDoAJG++neSQ6wOpiiNJPZhTO2AY2B6RLH4VRmT+wjSUEKjkYa8wcStKko7UnVXVHGIE7PmIeoZz4b5ZBc9dNzMx2m7oJ4TKYQuWRdtfwzzEzyjAaa0Guls96G1hIYS6KFkX+CcRhvzZ7DYiZ4+ThGlncJkWEe8PGm0FNU4lBZkJD+a5dUyaWmqh3HHNZOfETVHb8KZChW9g6e55dWlzpU8nsMXQeEBP8+QQoruYWYTfA2YxT55zm1ZSylDD7xIGi4zN72pJ3qH36y3V8XsWiQRl5gN0wQyLW+WyY2WQQax1nFFiuVTauS9nx8GicpHP+jKwT2AGGEeu02RG3odDx9GJimK5C/qjpthEk8btL
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m19-20020a170902c45300b001d960a29da2sm2097473plm.62.2024.02.09.17.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 17:16:44 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Dan Williams <dan.j.williams@intel.com>,
	Keith Packard <keithp@keithp.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/2] stddef: Allow attributes to be used when creating flex arrays
Date: Fri,  9 Feb 2024 17:16:40 -0800
Message-Id: <20240210011452.work.985-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=631; i=keescook@chromium.org;
 h=from:subject:message-id; bh=LjE7ZHH8ae5qMsodwhs2U36vGYqe75wMOHw6PFWF9AE=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlxs56CjBFfgU8SL4TcnflI84OzxGZaGCzXUwyD
 deewc09Y96JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcbOegAKCRCJcvTf3G3A
 JtV0D/9vYG6bnLydYrwF5KJxu7AlrI6LOPHKy3XOwsVbevcBwCkIhJ+ys+omM7o7Z6MLLp8fAwR
 vrQT5uqePajGvgcXsKtQBvzBxPMpS8CM5iJRn7Y1X5UTC+aFJtKiHoYYQXinHFioO9mobDrT/Nj
 eYV22Sl/LG7i92iLbjTuPOmuhsxRakLiVu9zNICvd+3LPlXrNDg58yloa4t5MQ2bUQInd/UCjwZ
 h+PZc6qzGAemw8zdnMr7KsMpFKI/PFzHphK3mkEtmRz7MZpPx1eKkxIuaV/TVbNxoFjZ/UdoTYE
 QPr14m1zemajq/+78yh3YyfvOnsJm8/uLfa28KDoV3hfGWJxQUPN4nIDDQCrtt7l2JExaq1kzy7
 OzCBrGa9KoYHZ6ZjA+8+DAeII5jBpVbm1OBy7VPdiFEPp1qR/9aEz/Ak0en9fW2YvUl1UigiTXh
 ABbGlaUnDxmG9CwElcqMGpHmQZ2buq1uxN4A51fUgi1fRF94qbbfmZdwGrRt3+El2W3Fkmzwwaq
 Rm14E2+cnrcRzSfABt7WsCiuiXdemzzBe9VSsfeCrS6wKRc5XnOSGnAo89gnfA/RMKE/z4mDHid
 +BAlSCzPV4GSHaYFzqlLYsBK7gyhUzq2nz5I310hm4n4pgjTewei6rSsCVCIpkrZg4W8EXzbUJi
 GF4RjB3P VW3rBkA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

We're going to have more cases where we need to apply attributes
(e.g. __counted_by) to struct members that have been declared with
DECLARE_FLEX_ARRAY. Add a new ..._ATTR helper to allow for this and
annotate one such user in linux/in.h.

-Kees

Kees Cook (2):
  stddef: Allow attributes to be used when creating flex arrays
  net/ipv4: Annotate imsf_slist_flex with __counted_by(imsf_numsrc)

 include/linux/stddef.h      | 16 ++++++++++++++--
 include/uapi/linux/in.h     |  3 ++-
 include/uapi/linux/stddef.h | 25 +++++++++++++++++++------
 3 files changed, 35 insertions(+), 9 deletions(-)

-- 
2.34.1

